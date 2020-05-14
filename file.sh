#!/bin/bash

generateFile() {
  # npm option

  npm explore $1 -- npm run $2
  # Assests Directory if i want to inset to specific package
  mkdir ./node_modules/$1/workspace
  mkdir ./node_modules/$1/workspace/custom
  mkdir ./node_modules/$1/workspace/custom/assets
  cd $3

  find -iname '*.jpg' -exec -cp {} ../node_modules/$1/workspace/custom/assets/ \;
  find -iname '*.png' -exec -cp {} ../node_modules/$1/workspace/custom/assets/ \;
  find -iname '*.JPEG' -exec -cp {} ../node_modules/$1/workspace/custom/assets/ \;
  find -iname '*.txt' -exec -cp {} ../node_modules/$1/workspace/custom/assets/ \;
  find -iname '*.xlsx' -exec -cp {} ../node_modules/$1/workspace/custom/assets/ \;
  find -iname '*.csv' -exec -cp {} ../node_modules/$1/workspace/custom/assets/ \;

  cd ..

  echo File Copy and Generated
}

GenerateFile
