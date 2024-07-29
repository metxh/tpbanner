
# Explanation:
QBCore Initialization: We initialize QBCore with QBCore = exports['qb-core']:GetCoreObject().
Player Management: The script uses QBCore's player management functions to get player data.
Database Operations: Uses oxmysql to handle database operations for inserting the ban record.
Commands: Registers a testban command using QBCore's command system.


# How to Use:
Save the Script: Save the script as a Lua file (e.g., ban_teleport_attempt_qb.lua) in your QBCore server's resources directory.
Resource Manifest: Ensure you have a __resource.lua or fxmanifest.lua file in the same directory to load this script.
Start the Resource: Add start <resource-name> in your server.cfg file.
Make sure to replace the example teleport detection logic with actual detection logic relevant to your server.

for custom works or projects please add us on discord : kxnsız / qatc
