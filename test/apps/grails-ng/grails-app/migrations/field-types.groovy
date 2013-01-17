databaseChangeLog = {

	changeSet(author: "rob (generated)", id: "1358406936189-1") {
		addColumn(tableName: "album") {
			column(name: "compilation", type: "boolean") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "rob (generated)", id: "1358406936189-2") {
		addColumn(tableName: "album") {
			column(name: "review_rating", type: "integer")
		}
	}

	changeSet(author: "rob (generated)", id: "1358406936189-3") {
		addColumn(tableName: "album") {
			column(name: "review_text", type: "varchar(255)")
		}
	}

}
