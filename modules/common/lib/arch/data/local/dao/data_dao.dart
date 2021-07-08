
import 'package:common/arch/data/local/db/app_db.dart';
import 'package:common/arch/data/local/entity/data_entity.dart';
import 'package:moor/moor.dart';

part 'data_dao.g.dart';

@UseDao(tables: [CityEntities])
class CityDao extends DatabaseAccessor<AppDatabase> with _$CityDaoMixin {
  CityDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<void> insertAll(List<Insertable<CityEntity>> list) => batch((batch) => batch.insertAll(cityEntities, list));
  Future<int> insert(Insertable<CityEntity> e) => into(cityEntities).insert(e);
  Future<int> deleteData(Insertable<CityEntity> e) => delete(cityEntities).delete(e);
  Future<List<CityEntity>> get({ int? limit, int? offset}) async {
    final sel = select(cityEntities);
    if(limit != null) {
      sel.limit(limit, offset: offset);
    }
    return sel.get();
  }
  Future<CityEntity?> getById(int id) => (select(cityEntities)..where((it) => it.id.equals(id))).getSingleOrNull();
  Future<CityEntity?> getByName(String name) => (select(cityEntities)..where((it) => it.name.equals(name))).getSingleOrNull();
}