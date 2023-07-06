import 'package:seller/modules/home/model/model_promos.dart';
import 'package:sstream/sstream.dart';

class HomeBloc {
  HomeBloc() {
    final data = listBanner.value;
    data.addAll([
      PromosModel(
        id: '1',
        title: 'tittle',
        description: 'description',
        startDate: 'startDate',
        endDate: 'endDate',
        imagesName: 'imagesName',
        imagesLink: 'assets/ikan.png',
      ),
      PromosModel(
        id: '1',
        title: 'tittle',
        description: 'description',
        startDate: 'startDate',
        endDate: 'endDate',
        imagesName: 'imagesName',
        imagesLink: 'assets/ikan.png',
      ),
      PromosModel(
        id: '1',
        title: 'tittle',
        description: 'description',
        startDate: 'startDate',
        endDate: 'endDate',
        imagesName: 'imagesName',
        imagesLink: 'assets/ikan.png',
      ),
    ]);
  }
  final listBanner = SStream<List<PromosModel>>([]);
}
