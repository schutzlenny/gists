// ==UserScript==
// @name Jenkins Job Linker
// @namespace Violentmonkey Scripts
// @match https://jenkins.sisu.sh/blue*
// @grant none
// ==/UserScript==

const $ = (s) => document.querySelector(s)
const $$ = (s) => document.querySelectorAll(s)

function makeUrl(job, id) {
  return `https://jenkins.sisu.sh/blue/organizations/jenkins/${job}/detail/${job}/${id}/pipeline`
}

function createButton (el, job, id, url) {
  const btn = document.createElement('a')
  btn.className = 'btn-link'
  btn.href = url
  btn.textContent = `Go to ${job} #${id}`
  btn.style.background = '#6C9E31'
  btn.style.borderRadius = '5px'
  btn.style.margin = '5px'
  btn.style.padding = '3px 10px'
  btn.style.color = 'white'
  
  el.appendChild(btn)
}

function grabUrl() {
  const logHeader = $('.result-item-head')
  if (!logHeader) {
    console.log('logHeader not found')
    setTimeout(grabUrl, 500)
    return
  }
  
  const logBoxes = $$('.result-item-head + span .log-boxes')
  if (!logBoxes || logBoxes.length < 1) {
    console.log('logBoxes not found')
    logHeader.click()
    setTimeout(grabUrl, 500)
    return
  }

  let url = ''
  let match = []
  const regex = /Starting building\:\ ([a-z-]*)\ \#([0-9]*)/
  for(t in logBoxes) {
    if(logBoxes.hasOwnProperty(t)) {
      match = regex.exec(logBoxes[t].textContent)
      
      if (match) {
        const job = match[1]
        const id = match[2]
        const url =  makeUrl(job, id)
        
        console.log('URL FOUND:', url)
        createButton(logHeader, job, id, url)
        return
      }
    }
  }
  console.log('url not found', logBoxes)
}


grabUrl()
