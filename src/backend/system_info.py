import psutil

class SystemInfo():

    def status(self):
        return {"status": "ok"}
    
    # CPU Utilization
    def cpuPercents(self):
        return psutil.cpu_percent(interval=1, percpu=True)
    
    # CPU Frequency
    def cpuFrequency(self):
        return psutil.cpu_freq(percpu=True)
    
    # CPU Temperatures
    def cpuTemperatures(self):
        return psutil.sensors_temperatures()
    
    # RAM Usage
    def ramUsage(self):
        return psutil.virtual_memory()
    
    # SSD Usage
    def diskUsage(self):
        return psutil.disk_usage('/home')
    
    # SSD-I/O
    def ssdIO(self):
        return psutil.disk_io_counters(perdisk=True)
    
    # Network Connections
    def networkIO(self):
        return psutil.net_io_counters(pernic=True)
    
    # Actice Network Connections
    def networkConnection(self):
        return psutil.net_connections()
    
    # System Boot Time
    def bootTime(self):
        return psutil.boot_time()
    
    # Running Processes
    def processes(self):
        output = []
        for x in psutil.process_iter():
            if x.status() != "sleeping" and x.status() != "zombie":
                print(x.status())
                output.append({x.name(): x.status()})
        return output
    