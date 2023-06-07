import 'package:catalago_japamix/base/models/banner/banners.dart';

abstract class IBannerService {
  Future<bool> create(Banners banner);
  Future<List<Banners>> getAll();
  Future<bool> deleteBanners();
}