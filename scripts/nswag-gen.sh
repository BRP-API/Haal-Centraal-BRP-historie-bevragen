#!/bin/bash

nswag run src/BrpHistorieStub/Server.nswag /runtime:Net60
nswag run src/BrpHistorieProxy/DataTransferObjects.nswag /runtime:Net60
nswag run src/BrpHistorieProxy/GbaDataTransferObjects.nswag /runtime:Net60
