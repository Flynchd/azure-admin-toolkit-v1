# Main menu function
function Display-MainMenu {
    param (
        [string]$Title = 'Azure Admin Toolkit v1'
    )
    Clear-Host
    Write-Host "================ $Title ================"

    Write-Host "1: Automated Deployment and Configuration"
    Write-Host "2: Diagnostic Tools"
    Write-Host "3: Performance Monitoring"
    Write-Host "4: Security Monitoring"
    Write-Host "5: Scripting Utilities"
    Write-Host "6: User-Friendly Interface"
    Write-Host "7: Resource Management"
    Write-Host "8: Scalability"
    Write-Host "9: Cost Savings"
    Write-Host "10: Enhanced Cloud Governance"
    Write-Host "Q: Quit"
}

# Submenu function
function Display-SubMenu ($Feature, $Scripts) {
    Clear-Host
    Write-Host "================ $Feature ================"

    Write-Host "1: $Scripts[0]"
    Write-Host "2: $Scripts[1]"
    Write-Host "3: $Scripts[2]"
    Write-Host "B: Back"
}

$FeatureScripts = @{
    'Automated Deployment and Configuration' = @('DeployAzureResources.ps1', 'ConfigureAzureNetwork.ps1', 'SetupAzureStorageAccounts.ps1')
    'Diagnostic Tools' = @('DiagnoseAzureVMIssues.ps1', 'AnalyzeAzureNetworkDiagnostics.ps1', 'AzureStorageAccountHealthCheck.ps1')
    'Performance Monitoring' = @('MonitorAzureVMPerformance.ps1', 'TrackAzureStoragePerformance.ps1', 'AzureSQLPerformanceAudit.ps1')
    'Security Monitoring' = @('AuditAzureSecurity.ps1', 'MonitorAzureFirewallLogs.ps1', 'CheckAzureIdentityAndAccess.ps1')
    'Scripting Utilities' = @('AzureAutomationScripts.ps1', 'AzureScriptingUtility.ps1', 'AzurePowershellScriptManager.ps1')
    'User-Friendly Interface' = @('InvokeAzureDashboard.ps1', 'GenerateAzureResourceReport.ps1', 'DisplayAzureBillingInfo.ps1')
    'Resource Management' = @('ManageAzureVMs.ps1', 'ControlAzureStorageAccounts.ps1', 'OperateAzureDatabases.ps1')
    'Scalability' = @('ScaleAzureVMs.ps1', 'AzureStorageScalabilityCheck.ps1', 'ScaleAzureSQLDatabases.ps1')
    'Cost Savings' = @('AnalyzeAzureCosts.ps1', 'OptimizeAzureResources.ps1', 'ReduceAzureStorageCosts.ps1')
    'Enhanced Cloud Governance' = @('EnforceAzurePolicies.ps1', 'CheckAzureCompliance.ps1', 'AuditAzureResourceUsage.ps1')
}

while($true) {
    Display-MainMenu
    $mainSelection = Read-Host "Please make a selection"
    $featureKeys = $FeatureScripts.Keys

    if ($featureKeys -contains $mainSelection) {
        while($true) {
            Display-SubMenu -Feature $featureKeys[$mainSelection-1] -Scripts $FeatureScripts[$featureKeys[$mainSelection-1]]
            $subSelection = Read-Host "Please make a selection"
            if($subSelection -eq 'B') { break }
            # Execute the corresponding script
            try {
                .\$featureKeys[$mainSelection-1]\$FeatureScripts[$featureKeys[$mainSelection-1]][[int]$subSelection-1]
            } catch {
                Write-Host "Error executing the script. Please ensure the script exists and is executable."
            }
        }
    } elseif ($mainSelection -eq 'Q') {
        return
    } else {
        Write-Host "Invalid option. Please choose a valid number or 'Q' to quit."
    }
}
