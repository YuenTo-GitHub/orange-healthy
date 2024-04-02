/**
 * 数据库建表语句
 */
import relationalStore from '@ohos.data.relationalStore'
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import RecordPO from '../common/bean/RecordPO'
import DbUtil from '../common/utils/DbUtil'

const CREATE_TABLE_SQL: string = `
 CREATE TABLE IF NOT EXISTS record (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   type_id INTEGER NOT NULL,
   item_id INTEGER NOT NULL,
   amount DOUBLE NOT NULL,
   create_time INTEGER NOT NULL
 )
 `

const COLUMNS: ColumnInfo[] = [
  { name: 'id', columnName: 'id', type: ColumnType.LONG },
  { name: 'typeId', columnName: 'type_id', type: ColumnType.LONG },
  { name: 'itemId', columnName: 'item_id', type: ColumnType.LONG },
  { name: 'amount', columnName: 'amount', type: ColumnType.DOUBLE },
  { name: 'createTime', columnName: 'create_time', type: ColumnType.LONG }
]

const TABLE_NAME = 'record'
const ID_COLUMN = 'id'
const DATE_COLUMN = 'create_time'
const TYPE_ID = 'type_id'

class RecordModel {
  getCreateTableSql(): string {
    return CREATE_TABLE_SQL
  }

  insert(record: RecordPO): Promise<number> {
    return DbUtil.insert(TABLE_NAME, record, COLUMNS)
  }

  deleteById(id: number): Promise<number> {
    // 1.删除条件
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(ID_COLUMN, id)
    // 2.删除
    return DbUtil.delete(predicates)
  }

  updateAmount(typeId: number, itemId: number, date: number, amount: number): Promise<number> {
    // 1.更新条件
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
      .equalTo(TYPE_ID, typeId)
      .equalTo('item_id', itemId)
      .equalTo(DATE_COLUMN, date)
    // 更新
    return DbUtil.update(TABLE_NAME, { 'amount': amount }, predicates)
  }

  listByDate(date: number): Promise<RecordPO[]> {
    // 1.查询条件
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(DATE_COLUMN, date)
    // 2.查询
    return DbUtil.selectForList(predicates, COLUMNS)
  }

  listByTypeId(typeId: number, date: number): Promise<RecordPO[]> {
    // 查询当日分组下的信息
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('type_id', typeId)
      .equalTo(DATE_COLUMN, date)
    return DbUtil.selectForList(predicates, COLUMNS)
  }
}

let recordModel = new RecordModel()

export default recordModel as RecordModel