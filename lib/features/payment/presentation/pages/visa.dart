import 'package:flutter/material.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/utils/constants.dart';

class VisaScreen extends StatefulWidget {
  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }
  void _initializeWebView() {
    // Check if token is available
    if (Constants.REQUEST_TOKEN_CARD.isEmpty) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Payment token not available. Please try again.';
      });
      return;
    }
    print("Initializing WebView with token: ${Constants.REQUEST_TOKEN_CARD}");
    // Initialize the WebViewController
    _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..setBackgroundColor(const Color(0x00000000))..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
            setState(() {
              _hasError = true;
              _errorMessage = 'Failed to load payment page: ${error.description}';
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigation request to: ${request.url}');

            // Check for success/failure URLs from Paymob
            if (request.url.contains('success') || request.url.contains('callback')) {
              print('Payment completed successfully!');
              // Handle successful payment
              _handlePaymentResult(true, 'Payment completed successfully!');
              return NavigationDecision.prevent;
            } else if (request.url.contains('error') || request.url.contains('fail')) {
              print('Payment failed!');
              // Handle failed payment
              _handlePaymentResult(false, 'Payment failed. Please try again.');
              return NavigationDecision.prevent;
            }

            // Block YouTube navigation as in original
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),)..addJavaScriptChannel('Toaster', onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },);
    // Load the payment iframe URL
    final iframeUrl = "https://accept.paymobsolutions.com/api/acceptance/iframes/862447?payment_token=${Constants.REQUEST_TOKEN_CARD}";
    print("Loading iframe URL: $iframeUrl");
    _controller.loadRequest(Uri.parse(iframeUrl));
  }
  void _handlePaymentResult(bool success, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(success ? "Payment Success" : "Payment Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home,(route) => false ); // Go back to cart
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _hasError ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _errorMessage = '';
                });
                _initializeWebView();
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ) : Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading payment page..."),
                ],
              ),
            ),
        ],
      ),
    );
  }
}