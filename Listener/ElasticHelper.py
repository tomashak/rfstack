from datetime import datetime
from elasticsearch import Elasticsearch

def logToElastic(elasticUrl='localhost:9200'):
    es = Elasticsearch()
    doc = {
            "testSuite": "NonAuthorization",
            "testCase": "SampleTestRF",
            "env": "preprod",
            "tags": ["Smoke", "APITest"],
            "description": "login lorem ipsum",
            "success": True,
            "error_msg": "empty",
            "detail_result_url": "https://URL_JENKINS/JOB/BUILD2/log.html",
            "duration": 999,
            "executionTime": datetime.now(),
            "note": "some text"
    }
    print("XXXXXXXXXXXXX elastic XXXXXXXXXXXXXX")
    res = es.index(index="test-rfstack", body=doc)
    print(res['result'])

    #res = es.get(index="rfstack", id="zwJM_XIBDK7FV3SDPj4l")
    #print(res['_source'])

    #es.indices.refresh(index="test-index")

    #res = es.search(index="test-index", body={"query": {"match_all": {}}})
    #print("Got %d Hits:" % res['hits']['total']['value'])
    #for hit in res['hits']['hits']:
    #    print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])
