from fastapi import FastAPI
import system_info

app = FastAPI()
systemInfo = system_info.SystemInfo()

@app.get("/status")
async def status():
    return systemInfo.status()

@app.get("/cpu_percents")
async def cpu_percents():
    return {"CPU AUSLASTUNG:": systemInfo.cpuPercents()}

@app.get("/cpu_frequency")
async def cpu_frequency():
    return {"CPU FREQUENZ:": systemInfo.cpuFrequency()}

@app.get("/cpu_temperatures")
async def cpu_temperatures():
    return {"CPU TEMPERATUR": systemInfo.cpuTemperatures()}

@app.get("/ram_usage")
async def ram_usage():
    return {"RAM NUTZUNG": systemInfo.ramUsage()}

@app.get("/disk_usage")
async def disk_usage():
    return {"FESTPLATTEN NUTZUNG": systemInfo.diskUsage()}

@app.get("/disk_io")
async def disk_io():
    return {"FESTPLATTEN-IO": systemInfo.ssdIO()}

@app.get("/network_io")
async def network_io():
    return {"NETZWERK-IO": systemInfo.networkIO()}

@app.get("/active_network")
async def network_connection():
    return {"NETZWERK-VERBINDUNG": systemInfo.networkConnection()}

@app.get("/boottime")
async def boottime():
    return {"BOOTZEIT": systemInfo.bootTime()}

@app.get("/running_processes")
async def processes():
    return {"PROZESSE": systemInfo.processes()}
