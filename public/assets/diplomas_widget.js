function resizePhotoContainers() {
  const photoContainers = document.querySelectorAll(".photo-container")
  const photoContainer = document.querySelector(".photo-container:not(.d-none)")
  if (photoContainer) {
    const photoContainerWidth = photoContainer.offsetWidth
    photoContainers.forEach(photoContainer => {
      photoContainer.style.maxHeight = `${photoContainerWidth}px`
    })
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const searchInputContainer = document.getElementById('search-input-container')
  const searchInput = document.getElementById('kapp10-filter')
  const recognitionSelect = document.getElementById('filterRecognition')
  const filterSexContainer = document.getElementById('filter-sex-container')
  const sexSelect = document.getElementById('filterSexe')
  const filtercategoryContainer = document.getElementById('filter-category-container')
  const categorySelect = document.getElementById('filterCategory')
  const raceDetailTabs = document.querySelectorAll('.race_detail_tab')
  const allRacesTab = document.getElementById('tab_all')
  const pagePreviousBtn = document.getElementById('page-previous')
  const pageNextBtn = document.getElementById('page-next')

  filterPhotos()

  searchInput.addEventListener('keyup', () => filterPhotos())
  recognitionSelect.addEventListener('change', () => {
    // Filter on Recognition
    if (recognitionSelect.value === 'without_recognition') {
      allRacesTab.checked = true
      filterSexContainer.classList.add('d-none')
      filtercategoryContainer.classList.add('d-none')
      searchInputContainer.classList.add('d-none')
    } else {
      filterSexContainer.classList.remove('d-none')
      filtercategoryContainer.classList.remove('d-none')
      searchInputContainer.classList.remove('d-none')
    }
    filterPhotos()
  })
  sexSelect.addEventListener('change', () => filterPhotos())
  if (categorySelect) categorySelect.addEventListener('change', () => filterPhotos())

  raceDetailTabs.forEach(raceDetailTab => {
    raceDetailTab.addEventListener('click', () => filterPhotos())
  })

  pagePreviousBtn.addEventListener('click', event => filterPhotos(Number.parseInt(event.currentTarget.dataset.pageNumber)))
  pageNextBtn.addEventListener('click', event => filterPhotos(Number.parseInt(event.currentTarget.dataset.pageNumber)))
})

window.addEventListener('resize', () => {
  resizePhotoContainers()

  const activePageNumber = document.querySelector('.page-number.active')
  if (activePageNumber) {
    const pageNumber = Number.parseInt(activePageNumber.dataset.pageNumber)
    filterPhotos(pageNumber)
  }
})

function getNumberOfPhotos() {
  if (window.innerWidth >= 992) {
    return 60
  } else if (window.innerWidth >= 768) {
    return 40
  } else {
    return 20
  }
}

function filterPhotos(pageNumber = 1) {
  const searchInput = document.getElementById('kapp10-filter')
  const recognitionSelect = document.getElementById('filterRecognition')
  const sexSelect = document.getElementById('filterSexe')
  const categorySelect = document.getElementById('filterCategory')
  const raceTabSelected = document.querySelector('.race_detail_tab:checked')
  const searchInputValue = searchInput.value
  const recognitionSelectedValue = recognitionSelect.value
  const sexSelectedValue = sexSelect.value
  const categorySelectedValue = categorySelect.value
  const raceTabSelectedValue = raceTabSelected.dataset.value
  const photosContainerRow = document.querySelector('.photos-container .row')
  const numberPhotosByPage = getNumberOfPhotos()
  const paginationContainer = document.querySelector('.pagination-container')
  const pageNumbersElements = document.querySelector('.page-numbers')
  const pagePreviousBtn = document.getElementById('page-previous')
  const pageNextBtn = document.getElementById('page-next')

  let activePage, pageBtnElement

  const diplomasData = JSON.parse(document.getElementById('diplomas-data').dataset.diplomasData)
  console.log("Diplomas: " + JSON.stringify(diplomasData));
  let diplomasDataFiltered = diplomasData;
  console.log("Filtered Diplomas: " + JSON.stringify(diplomasDataFiltered));

  diplomasDataFiltered = diplomasDataFiltered.filter(data => {
    let photoToKeep = true

    // Filter on Recognition
    if (recognitionSelectedValue !== 'all') {
      if (recognitionSelectedValue === 'with_recognition') {
        photoToKeep = photoToKeep && (data.url !== null)
      } else if (recognitionSelectedValue === 'without_recognition') {
        return data.url === null
      }
    }

    // Filter on Race
    if (raceTabSelectedValue !== 'all') {
      photoToKeep = photoToKeep && (data.race === raceTabSelectedValue)
    }


    // Filter on Sex
    if (sexSelectedValue !== 'all') {
      console.log("sex: " + sexSelectedValue);
      photoToKeep = photoToKeep && (data.sex === sexSelectedValue)
    }

    // Filter on Category
    if (categorySelect && categorySelectedValue !== 'all') {
      photoToKeep = photoToKeep && (data.categ === categorySelectedValue)
    }

    // Filter on Search
    if (searchInputValue !== "") {
      if (Number.isInteger(Number.parseInt(searchInputValue))) {
        photoToKeep = photoToKeep && (data.rank === Number.parseInt(searchInputValue))
      } else {
        const matchValue = data.lastname.toLowerCase().match(searchInputValue.toLowerCase())
        photoToKeep = photoToKeep && (matchValue && matchValue[0])
      }
    }

    return photoToKeep
  })


  const numberOfPages = Math.ceil(diplomasDataFiltered.length / numberPhotosByPage)
  console.log("pages: " + numberOfPages);

  // Filter on the first page
  diplomasDataFiltered = diplomasDataFiltered.slice((pageNumber - 1) * numberPhotosByPage, pageNumber * numberPhotosByPage)

  photosContainerRow.innerHTML = ''
  diplomasDataFiltered.forEach(diplomasData => {
    let photoHoverTextElements = []

    if (diplomasData.firstname !== null && diplomasData.lastname !== '') {
      photoHoverTextElements.push(`${diplomasData.firstname} (${diplomasData.lastname})`);
    }

    if (diplomasData.name !== '') {
      photoHoverTextElements.push(diplomasData.name);
    }

    const photoHoverText = photoHoverTextElements.join('<br>')

    let photoHoverTextHTML = ''
    if (photoHoverText !== '') {
      photoHoverTextHTML = `<p>${photoHoverText}</p>`
    }

    const photoHTML = `<div class="col-xs-6 col-sm-6 col-md-3 col-lg-2 photo-container">` +
      `<a href="/results/${diplomasData.result_id}/email_diploma" target="_blank">` +
      `<div class="photo-front-hover-container">` +
      '<div class="photo-front">' +
      `<img src="${diplomasData.url}">` +
      '</div>' +
      '<div class="photo-hover">' +
      photoHoverTextHTML +
      '<p><i class="fas fa-download"></i></p>' +
      '</div>'
    '</div>' +
      '</a>' +
      '</div>'
    photosContainerRow.insertAdjacentHTML('beforeend', photoHTML)
  })

  if (diplomasDataFiltered.length === 0) {
    photosContainerRow.innerHTML = '<div class="col-xs-12 noResults">Pas de résultats</div>'
  }

  if (numberOfPages > 1) {
    let beginningNumberPage, endNumberPage

    if (pageNumber === 1) {
      beginningNumberPage = 1
    } else if (pageNumber === numberOfPages) {
      beginningNumberPage = pageNumber - 2
    } else {
      beginningNumberPage = pageNumber - 1
    }

    if (numberOfPages < beginningNumberPage + 2) {
      endNumberPage = numberOfPages
    } else {
      endNumberPage = beginningNumberPage + 2
    }

    pageNumbersElements.innerHTML = ''

    for (let i = beginningNumberPage; i <= endNumberPage; i++) {
      if (i === pageNumber) {
        activePage = 'active'
      } else {
        activePage = ''
      }

      pageNumbersElements.insertAdjacentHTML('beforeend', `<li id="page-${i}" data-page-number="${i}" class="page-item page-number ${activePage}">${i}</li>`)
      pageBtnElement = document.getElementById(`page-${i}`)
      pageBtnElement.addEventListener('click', event => filterPhotos(Number.parseInt(event.currentTarget.dataset.pageNumber)))
    }

    paginationContainer.classList.remove('d-none')

    if (pageNumber === 1) {
      pagePreviousBtn.classList.add('d-none')
    } else {
      pagePreviousBtn.dataset.pageNumber = pageNumber - 1
      pagePreviousBtn.classList.remove('d-none')
    }

    if (pageNumber === numberOfPages) {
      pageNextBtn.classList.add('d-none')
    } else {
      pageNextBtn.dataset.pageNumber = pageNumber + 1
      pageNextBtn.classList.remove('d-none')
    }
  } else {
    paginationContainer.classList.add('d-none')
  }

  resizePhotoContainers()
}
