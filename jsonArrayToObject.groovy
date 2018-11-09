return process(payload)

def process(String payload) {
    def events = new groovy.json.JsonSlurper().parseText(payload)
    def stringBuffer = new StringBuffer()
    def date = new Date().format("yyyy-MM-dd'T'HH:mm:ss'Z'")
    events.each {
        it.each {key, val ->
            if (val.isDouble()) {
                it[key] = val.toDouble()
            }
            if (val.isInteger()) {
                it[key] = val.toInteger()
            }
        }
        it.timestamp = date
        stringBuffer.append(groovy.json.JsonOutput.toJson(it)).append(System.lineSeparator())
    }

    return stringBuffer.toString()
}
