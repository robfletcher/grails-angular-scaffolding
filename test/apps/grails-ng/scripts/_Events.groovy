eventCfUpdateStart = {
    metadata.'cf.last.deployed' = new Date().format("yyyy-MM-dd'T'HH:mm:ssZ")
    metadata.persist()
}