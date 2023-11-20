import 'package:get/get.dart';
import 'package:rosary/data/repository/bugFeedback_repo.dart';
import 'package:rosary/model/payPal.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/payment_repo.dart';
import '../model/currency_model.dart';
import '../model/response_model.dart';

class PaymentController extends GetxController implements GetxService {
  final PaymentRepo paymentRepo;
  final SharedPreferences sharedPreferences;
  List<CurrencyModel> currencies = [
    CurrencyModel(code: 'USD', country: 'United States'),
    CurrencyModel(code: 'AED', country: 'United Arab Emirates'),
    CurrencyModel(code: 'AFN', country: 'Afghanistan'),
    CurrencyModel(code: 'ALL', country: 'Albania'),
    CurrencyModel(code: 'AMD', country: 'Armenia'),
    CurrencyModel(code: 'ANG', country: 'Netherlands Antilles'),
    CurrencyModel(code: 'AOA', country: 'Angola'),
    CurrencyModel(code: 'ARS', country: 'Argentina'),
    CurrencyModel(code: 'AUD', country: 'Australia'),
    CurrencyModel(code: 'AWG', country: 'Aruba'),
    CurrencyModel(code: 'AZN', country: 'Azerbaijan'),
    CurrencyModel(code: 'BAM', country: 'Bosnia and Herzegovina'),
    CurrencyModel(code: 'BBD', country: 'Barbados'),
    CurrencyModel(code: 'BDT', country: 'Bangladesh'),
    CurrencyModel(code: 'BGN', country: 'Bulgaria'),
    CurrencyModel(code: 'BIF', country: 'Burundi'),
    CurrencyModel(code: 'BMD', country: 'Bermuda'),
    CurrencyModel(code: 'BND', country: 'Brunei'),
    CurrencyModel(code: 'BOB', country: 'Bolivia'),
    CurrencyModel(code: 'BRL', country: 'Brazil'),
    CurrencyModel(code: 'BSD', country: 'Bahamas'),
    CurrencyModel(code: 'BWP', country: 'Botswana'),
    CurrencyModel(code: 'BYN', country: 'Belarus'),
    CurrencyModel(code: 'BZD', country: 'Belize'),
    CurrencyModel(code: 'CAD', country: 'Canada'),
    CurrencyModel(code: 'CDF', country: 'Democratic Republic of the Congo'),
    CurrencyModel(code: 'CHF', country: 'Switzerland'),
    CurrencyModel(code: 'CLP', country: 'Chile'),
    CurrencyModel(code: 'CNY', country: 'China'),
    CurrencyModel(code: 'COP', country: 'Colombia'),
    CurrencyModel(code: 'CRC', country: 'Costa Rica'),
    CurrencyModel(code: 'CVE', country: 'Cape Verde'),
    CurrencyModel(code: 'CZK', country: 'Czech Republic'),
    CurrencyModel(code: 'DJF', country: 'Djibouti'),
    CurrencyModel(code: 'DKK', country: 'Denmark'),
    CurrencyModel(code: 'DOP', country: 'Dominican Republic'),
    CurrencyModel(code: 'DZD', country: 'Algeria'),
    CurrencyModel(code: 'EGP', country: 'Egypt'),
    CurrencyModel(code: 'ETB', country: 'Ethiopia'),
    CurrencyModel(code: 'EUR', country: 'Eurozone'),
    CurrencyModel(code: 'FJD', country: 'Fiji'),
    CurrencyModel(code: 'FKP', country: 'Falkland Islands'),
    CurrencyModel(code: 'GBP', country: 'United Kingdom'),
    CurrencyModel(code: 'GEL', country: 'Georgia'),
    CurrencyModel(code: 'GIP', country: 'Gibraltar'),
    CurrencyModel(code: 'GMD', country: 'Gambia'),
    CurrencyModel(code: 'GNF', country: 'Guinea'),
    CurrencyModel(code: 'GTQ', country: 'Guatemala'),
    CurrencyModel(code: 'GYD', country: 'Guyana'),
    CurrencyModel(code: 'HKD', country: 'Hong Kong'),
    CurrencyModel(code: 'HNL', country: 'Honduras'),
    CurrencyModel(code: 'HTG', country: 'Haiti'),
    CurrencyModel(code: 'HUF', country: 'Hungary'),
    CurrencyModel(code: 'IDR', country: 'Indonesia'),
    CurrencyModel(code: 'ILS', country: 'Israel'),
    CurrencyModel(code: 'INR', country: 'India'),
    CurrencyModel(code: 'ISK', country: 'Iceland'),
    CurrencyModel(code: 'JMD', country: 'Jamaica'),
    CurrencyModel(code: 'JPY', country: 'Japan'),
    CurrencyModel(code: 'KES', country: 'Kenya'),
    CurrencyModel(code: 'KGS', country: 'Kyrgyzstan'),
    CurrencyModel(code: 'KHR', country: 'Cambodia'),
    CurrencyModel(code: 'KMF', country: 'Comoros'),
    CurrencyModel(code: 'KRW', country: 'South Korea'),
    CurrencyModel(code: 'KYD', country: 'Cayman Islands'),
    CurrencyModel(code: 'KZT', country: 'Kazakhstan'),
    CurrencyModel(code: 'LAK', country: 'Laos'),
    CurrencyModel(code: 'LBP', country: 'Lebanon'),
    CurrencyModel(code: 'LKR', country: 'Sri Lanka'),
    CurrencyModel(code: 'LRD', country: 'Liberia'),
    CurrencyModel(code: 'LSL', country: 'Lesotho'),
    CurrencyModel(code: 'MAD', country: 'Morocco'),
    CurrencyModel(code: 'MDL', country: 'Moldova'),
    CurrencyModel(code: 'MGA', country: 'Madagascar'),
    CurrencyModel(code: 'MKD', country: 'North Macedonia'),
    CurrencyModel(code: 'MMK', country: 'Myanmar'),
    CurrencyModel(code: 'MNT', country: 'Mongolia'),
    CurrencyModel(code: 'MOP', country: 'Macau'),
    CurrencyModel(code: 'MUR', country: 'Mauritius'),
    CurrencyModel(code: 'MVR', country: 'Maldives'),
    CurrencyModel(code: 'MWK', country: 'Malawi'),
    CurrencyModel(code: 'MXN', country: 'Mexico'),
    CurrencyModel(code: 'MYR', country: 'Malaysia'),
    CurrencyModel(code: 'MZN', country: 'Mozambique'),
    CurrencyModel(code: 'NAD', country: 'Namibia'),
    CurrencyModel(code: 'NGN', country: 'Nigeria'),
    CurrencyModel(code: 'NIO', country: 'Nicaragua'),
    CurrencyModel(code: 'NOK', country: 'Norway'),
    CurrencyModel(code: 'NPR', country: 'Nepal'),
    CurrencyModel(code: 'NZD', country: 'New Zealand'),
    CurrencyModel(code: 'PAB', country: 'Panama'),
    CurrencyModel(code: 'PEN', country: 'Peru'),
    CurrencyModel(code: 'PGK', country: 'Papua New Guinea'),
    CurrencyModel(code: 'PHP', country: 'Philippines'),
    CurrencyModel(code: 'PKR', country: 'Pakistan'),
    CurrencyModel(code: 'PLN', country: 'Poland'),
    CurrencyModel(code: 'PYG', country: 'Paraguay'),
    CurrencyModel(code: 'QAR', country: 'Qatar'),
    CurrencyModel(code: 'RON', country: 'Romania'),
    CurrencyModel(code: 'RSD', country: 'Serbia'),
    CurrencyModel(code: 'RUB', country: 'Russia'),
    CurrencyModel(code: 'RWF', country: 'Rwanda'),
    CurrencyModel(code: 'SAR', country: 'Saudi Arabia'),
    CurrencyModel(code: 'SBD', country: 'Solomon Islands'),
    CurrencyModel(code: 'SCR', country: 'Seychelles'),
    CurrencyModel(code: 'SEK', country: 'Sweden'),
    CurrencyModel(code: 'SGD', country: 'Singapore'),
    CurrencyModel(code: 'SHP', country: 'Saint Helena'),
    CurrencyModel(code: 'SLE', country: 'Sierra Leone'),
    CurrencyModel(code: 'SOS', country: 'Somalia'),
    CurrencyModel(code: 'SRD', country: 'Suriname'),
    CurrencyModel(code: 'STD', country: 'São Tomé and Príncipe'),
    CurrencyModel(code: 'SZL', country: 'Eswatini'),
    CurrencyModel(code: 'THB', country: 'Thailand'),
    CurrencyModel(code: 'TJS', country: 'Tajikistan'),
    CurrencyModel(code: 'TOP', country: 'Tonga'),
    CurrencyModel(code: 'TRY', country: 'Turkey'),
    CurrencyModel(code: 'TTD', country: 'Trinidad and Tobago'),
    CurrencyModel(code: 'TWD', country: 'Taiwan'),
    CurrencyModel(code: 'TZS', country: 'Tanzania'),
    CurrencyModel(code: 'UAH', country: 'Ukraine'),
    CurrencyModel(code: 'UGX', country: 'Uganda'),
    CurrencyModel(code: 'UYU', country: 'Uruguay'),
    CurrencyModel(code: 'UZS', country: 'Uzbekistan'),
    CurrencyModel(code: 'VND', country: 'Vietnam'),
    CurrencyModel(code: 'VUV', country: 'Vanuatu'),
    CurrencyModel(code: 'WST', country: 'Samoa'),
    CurrencyModel(code: 'XAF', country: 'Central African CFA franc'),
    CurrencyModel(code: 'XCD', country: 'East Caribbean Dollar'),
    CurrencyModel(code: 'XOF', country: 'West African CFA franc'),
    CurrencyModel(code: 'XPF', country: 'CFP franc'),
    CurrencyModel(code: 'YER', country: 'Yemen'),
    CurrencyModel(code: 'ZAR', country: 'South Africa'),
    CurrencyModel(code: 'ZMW', country: 'Zambia'),
  ];

  PaymentController(
      {required this.paymentRepo, required this.sharedPreferences});

  late PaypalModel _paypalResponse;
  PaypalModel get paypalResponse => _paypalResponse;

  bool _isLoaded = true;
  bool get isLoaded => _isLoaded;

  bool _isCurrencyLoaded = true;
  bool get isCurrencyLoaded => _isCurrencyLoaded;

  List<CurrencyModel> get currencyList =>
      _currencyList.length == 0 ? currencies : _currencyList;
  List<CurrencyModel> _currencyList = [];

  String _paymentUrl = "";
  String get paymentUrl => _paymentUrl;

  String _currency = "";
  String get currency => _currency;

  String _payerId = "";
  String get payerId => _payerId;

  String _paymentId = "";
  String get paymentId => _paymentId;

  String _sessionId = "";
  String get sessionId => _sessionId;

  String _amount = "";
  String get amount => _amount;

  Future<ResponseModel> pay(String amount, String currency) async {
    try {
      _currency = currency;
      _amount = amount;
      _isLoaded = false;
      update();
      Response response = await paymentRepo.postPayment(amount, currency);

      if (response.statusCode == 200) {
        print(response.body);
        _paypalResponse = PaypalModel.fromJson(response.body);
        _isLoaded = true;

        update();
        return ResponseModel(true, "OK");
      } else {
        showCustomSnackBar("donate_error_network".tr);
        _isLoaded = true;
        update();
        return ResponseModel(false, "OK");
      }
    } catch (err) {
      _isLoaded = true;
      update();
      return ResponseModel(false, "OK");
    }
  }

  Future<void> getCurrencyList() async {
    try {
      _isCurrencyLoaded = false;
      update();
      Response response = await paymentRepo.postCurrency();

      if (response.statusCode == 200) {
        print(response.body);
        _currencyList = [];
        _currencyList.addAll(Currency.fromJson(response.body).currencies);
      }
    } catch (err) {
      print(err);
    } finally {
      _isCurrencyLoaded = true;
      update();
    }
  }

  Future<ResponseModel> stripePayment(String amount) async {
    try {
      _isLoaded = false;
      update();
      Response response = await paymentRepo.postSripePayment(
        amount,
      );

      if (response.statusCode == 200) {
        print(response.body);
        _sessionId = response.body;

        _isLoaded = true;

        update();
        return ResponseModel(true, "OK");
      } else {
        showCustomSnackBar("donate_error_network".tr);
        _isLoaded = true;
        update();
        return ResponseModel(false, "OK");
      }
    } catch (err) {
      _isLoaded = true;
      update();
      return ResponseModel(false, "OK");
    }
  }
}
