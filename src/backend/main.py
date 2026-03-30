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