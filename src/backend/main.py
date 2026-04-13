from fastapi import FastAPI
import system_info

app = FastAPI()
systemInfo = system_info.SystemInfo()

@app.get("/status")
async def status():
    return systemInfo.status()

@app.get("/cpu_percents")
async def cpu_percents():
    return {"cpu_percents": systemInfo.cpuPercents()}

@app.get("/cpu_frequency")
async def cpu_frequency():
    return {"cpu_frequency": systemInfo.cpuFrequency()}

@app.get("/cpu_temperatures")
async def cpu_temperatures():
    return {"cpu_temperatures": systemInfo.cpuTemperatures()}

@app.get("/ram_usage")
async def ram_usage():
    return {"ram_usage": systemInfo.ramUsage()}

@app.get("/disk_usage")
async def disk_usage():
    return {"disk_usage": systemInfo.diskUsage()}

@app.get("/disk_io")
async def disk_io():
    return {"disk_io": systemInfo.ssdIO()}

@app.get("/network_io")
async def network_io():
    return {"network_io": systemInfo.networkIO()}

@app.get("/active_network")
async def network_connection():
    return {"active_network": systemInfo.networkConnection()}

@app.get("/boottime")
async def boottime():
    return {"boottime": systemInfo.bootTime()}

@app.get("/running_processes")
async def processes():
    return {"running_processes": systemInfo.processes()}
