#script to find the size of the azure Repos
git --version
 
$env:AZURE_DEVOPS_EXT_PAT = 'mention the access token'
 
$org = "https://centrica-emt.visualstudio.com/"

#$projects = az devops project list --organization $org --query #'value[].name' -o tsv
 
 
$projects = "DNA"

$projects
 
foreach ($proj in $projects) {

  $repos = az repos list --organization $org --project $proj | ConvertFrom-Json

  foreach ($repo in $repos) {

    if (-not (Test-Path -Path $Repo.name -PathType Container)) {

      Write-Warning -Message "Cloning repo $proj\$($repo.Name)"

      git -c http.extraheader="AUTHORIZATION: bearer $(System.AccessToken)" clone $repo.webUrl

    }

  }

}

$projectSize = 0

$totalSize = 0

echo "Measure size of all repositories"

foreach ($repo in Get-ChildItem ".") {

  $size = 0

  $files = 0
 
  foreach ($file in Get-ChildItem $repo -Recurse -Force -ErrorAction SilentlyContinue) {

    if ($file.FullName -like "*\.git\*") {

       echo "Skipping file $file under git"

    } else {

      $size += $file.Length

      $files += 1    

      # echo "Measuring $file : $size $files"

    }

  }

  $projectSize += $size

  $name = $repo.Name

  echo "$name,$size,$files"

}

echo "Project size: $projectSize"
 
 
 
 
 
 
