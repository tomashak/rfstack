import os.path
import requests
import time
import string
from datetime import datetime


class PythonListener:

    ROBOT_LISTENER_API_VERSION = 2
    actual_suite =  "N/A"
    JENKINS_BUILD_URL= "http://localhost:8081/job/RFStack/2/"



    def __init__(self, filename='listen.txt'):
        outpath = os.path.join("Listener/", filename)
        print("outpath: " + outpath)
        self.outfile = open(outpath, 'w')

    def start_suite(self, name, attrs):
        self.outfile.write("Suite %s '%s'\n" % (name, attrs['doc']))
        self.actual_suite = name

    def start_test(self, name, attrs):
        tags = ' '.join(attrs['tags'])
        self.outfile.write("- %s '%s' [ %s ] :: " % (name, attrs['doc'], tags))

    def end_test(self, name, attrs):
        success = False
        if attrs['status'] == 'PASS':
            self.outfile.write('PASS\n')
            success = True
        else:
            self.outfile.write('FAIL: %s\n' % attrs['message'])
        self.logToElasticTestResult(testSuite=self.actual_suite,
                                    testCase=name,
                                    env="INT",
                                    description=attrs['doc'],
                                    tags=' '.join(attrs['tags']),
                                    success=success,
                                    error_msg=attrs['message'][0:300]+" ...",
                                    result_url=self.JENKINS_BUILD_URL,
                                    duration=attrs['elapsedtime'],
                                    note="Žluťoučký kůň úpí")

    def end_suite(self, name, attrs):
        self.outfile.write('%s\n%s\n' % (attrs['status'], attrs['message']))

    def close(self):
       self.outfile.close()

    def logToElasticTestResult(self,testSuite,testCase,description,env,tags,success,error_msg,result_url,duration,note="empty note",elasticUrl='http://localhost:9200'):
        now = datetime.now()
        data = {"testSuite" : testSuite,
                "testCase" : testCase,
                "env" : env,
                "tags" : tags,
                "description" : description,
                "success" : success,
                "error_msg" : error_msg,
                "detail_result_url" : result_url,
                "duration": duration,
                "executionTime":now.strftime("%Y-%m-%dT%H:%M:%S+02:00"),
                "note":note}
        resp = requests.post(elasticUrl+'/rfstack/_create/'+str(int(round(time.time() * 1000))),  headers={'Content-Type':'application/json'}, json=data)
        if resp.status_code != 201:
            self.outfile.write('POST /rfstack/_create/ {}'.format(resp.status_code))
            self.outfile.write('response: '+resp.text)

