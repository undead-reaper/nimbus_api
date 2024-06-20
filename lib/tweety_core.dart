import 'package:puppeteer/puppeteer.dart';
import 'package:puppeteer/src/devices.dart';

class TweetyCore {
  late Browser browser;
  late Page page;

  Future<void> initialize() async {
    browser = await puppeteer.launch(headless: true);
    page = await browser.newPage();

    await page.emulate(devices.iPadPro11Landscape);
    await page.setUserAgent(
      'Mozilla/5.0 (Macintosh; '
      'Intel Mac OS X 10_15_7) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/95.0.4638.69'
      'Safari/537.36',
    );
  }

  Future<void> closeBrowser() async => browser.close();

  Future<Response> goto(String url) {
    return page.goto(url, wait: Until.networkIdle);
  }

  Future<List<int>> screenshotTweet() async {
    final tweet = await page.$('article');
    return tweet.screenshot();
  }

  Future<T?> getTweetText<T>() async {
    final tweet = await page.$('article div[lang]');
    return tweet.$$eval(
      'article div[lang]',
      '(tweets) => tweets.map((tweet) => tweet.textContent)',
    );
  }
}
