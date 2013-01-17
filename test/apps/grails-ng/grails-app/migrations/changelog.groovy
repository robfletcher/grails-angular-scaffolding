databaseChangeLog = {

	changeSet(author: "rob (generated)", id: "1358405807992-1") {
		createTable(tableName: "album") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "albumPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "artist", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "year", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "rob (generated)", id: "1358405807992-2") {
		createIndex(indexName: "unique_title", tableName: "album", unique: "true") {
			column(name: "artist")

			column(name: "title")
		}
	}
}
