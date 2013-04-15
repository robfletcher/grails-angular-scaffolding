databaseChangeLog = {

	changeSet(author: "rob (generated)", id: "1358406936189-1") {

		preConditions(onFail: 'MARK_RAN') {
			not {
				columnExists tableName: 'album', columnName: 'compilation'
			}
		}

		addColumn(tableName: "album") {
			column(name: "compilation", type: "boolean") {
				constraints(nullable: "false")
			}
		}

	}

	changeSet(author: "rob (generated)", id: "1358406936189-2") {

		preConditions(onFail: 'MARK_RAN') {
			not {
				columnExists tableName: 'album', columnName: 'review_rating'
			}
		}

		addColumn(tableName: "album") {
			column(name: "review_rating", type: "integer")
		}

	}

	changeSet(author: "rob (generated)", id: "1358406936189-3") {


		preConditions(onFail: 'MARK_RAN') {
			not {
				columnExists tableName: 'album', columnName: 'review_text'
			}
		}

		addColumn(tableName: "album") {
			column(name: "review_text", type: "varchar(255)")
		}

	}

}
