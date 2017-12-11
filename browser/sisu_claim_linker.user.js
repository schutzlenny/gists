// ==UserScript==
// @name Sisu Claim Linker
// @namespace Violentmonkey Scripts
// @match *://*/certificate/*/show
// @match *://*/certificate/*/edit
// @grant none
// ==/UserScript==

const $certificateNumber = $('[name*="certificateNumber"],.sonata-ba-view > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(2) > td:nth-child(2)')
const $pin = $('[name*="pin"],.sonata-ba-view > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(4) > td:nth-child(2)')
const $el = $('div.grid-item:nth-child(1) > div:nth-child(1) > fieldset:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > label:nth-child(1), .sonata-ba-view > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(4) > th:nth-child(1)')

const cert = $certificateNumber.val() || $certificateNumber.text()
const pin = $pin.val() || $pin.text()

function createButton (el, cert, pin, url) {
  const btn = document.createElement('button')
  btn.className = 'btn btn-info btn-xs'
  btn.textContent = `File claim`
  btn.style.float = 'right';
  
  btn.addEventListener('click', e => {   
    const newForm = $('<form>', {
      'action': '/claims',
      'method': 'post'
    }).append(jQuery('<input>', {
      'name': 'certificate[certificateNumber]',
      'value': cert,
      'type': 'hidden'
    })).append(jQuery('<input>', {
      'name': 'certificate[pin]',
      'value': pin,
      'type': 'hidden'
    }));
    newForm.appendTo('body').submit();
  })
  
  el.appendChild(btn)
}

createButton($el[0], cert, pin, 'www')
