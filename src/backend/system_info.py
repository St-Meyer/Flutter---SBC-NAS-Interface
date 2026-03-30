import psutil

class SystemInfo():

    def status(self):
        return {"status": "ok"}
    
    def cpuPercents(self):
        return psutil.cpu_percent(interval=1, percpu=True)