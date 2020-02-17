/*
 **	Filters
 */

function removeDiacritics (str) {
  var defaultDiacriticsRemovalMap = [
    {'base':'A', 'letters':/[\u0041\u24B6\uFF21\u00C0\u00C1\u00C2\u1EA6\u1EA4\u1EAA\u1EA8\u00C3\u0100\u0102\u1EB0\u1EAE\u1EB4\u1EB2\u0226\u01E0\u00C4\u01DE\u1EA2\u00C5\u01FA\u01CD\u0200\u0202\u1EA0\u1EAC\u1EB6\u1E00\u0104\u023A\u2C6F]/g},
    {'base':'AA','letters':/[\uA732]/g},
    {'base':'AE','letters':/[\u00C6\u01FC\u01E2]/g},
    {'base':'AO','letters':/[\uA734]/g},
    {'base':'AU','letters':/[\uA736]/g},
    {'base':'AV','letters':/[\uA738\uA73A]/g},
    {'base':'AY','letters':/[\uA73C]/g},
    {'base':'B', 'letters':/[\u0042\u24B7\uFF22\u1E02\u1E04\u1E06\u0243\u0182\u0181]/g},
    {'base':'C', 'letters':/[\u0043\u24B8\uFF23\u0106\u0108\u010A\u010C\u00C7\u1E08\u0187\u023B\uA73E]/g},
    {'base':'D', 'letters':/[\u0044\u24B9\uFF24\u1E0A\u010E\u1E0C\u1E10\u1E12\u1E0E\u0110\u018B\u018A\u0189\uA779]/g},
    {'base':'DZ','letters':/[\u01F1\u01C4]/g},
    {'base':'Dz','letters':/[\u01F2\u01C5]/g},
    {'base':'E', 'letters':/[\u0045\u24BA\uFF25\u00C8\u00C9\u00CA\u1EC0\u1EBE\u1EC4\u1EC2\u1EBC\u0112\u1E14\u1E16\u0114\u0116\u00CB\u1EBA\u011A\u0204\u0206\u1EB8\u1EC6\u0228\u1E1C\u0118\u1E18\u1E1A\u0190\u018E]/g},
    {'base':'F', 'letters':/[\u0046\u24BB\uFF26\u1E1E\u0191\uA77B]/g},
    {'base':'G', 'letters':/[\u0047\u24BC\uFF27\u01F4\u011C\u1E20\u011E\u0120\u01E6\u0122\u01E4\u0193\uA7A0\uA77D\uA77E]/g},
    {'base':'H', 'letters':/[\u0048\u24BD\uFF28\u0124\u1E22\u1E26\u021E\u1E24\u1E28\u1E2A\u0126\u2C67\u2C75\uA78D]/g},
    {'base':'I', 'letters':/[\u0049\u24BE\uFF29\u00CC\u00CD\u00CE\u0128\u012A\u012C\u0130\u00CF\u1E2E\u1EC8\u01CF\u0208\u020A\u1ECA\u012E\u1E2C\u0197]/g},
    {'base':'J', 'letters':/[\u004A\u24BF\uFF2A\u0134\u0248]/g},
    {'base':'K', 'letters':/[\u004B\u24C0\uFF2B\u1E30\u01E8\u1E32\u0136\u1E34\u0198\u2C69\uA740\uA742\uA744\uA7A2]/g},
    {'base':'L', 'letters':/[\u004C\u24C1\uFF2C\u013F\u0139\u013D\u1E36\u1E38\u013B\u1E3C\u1E3A\u0141\u023D\u2C62\u2C60\uA748\uA746\uA780]/g},
    {'base':'LJ','letters':/[\u01C7]/g},
    {'base':'Lj','letters':/[\u01C8]/g},
    {'base':'M', 'letters':/[\u004D\u24C2\uFF2D\u1E3E\u1E40\u1E42\u2C6E\u019C]/g},
    {'base':'N', 'letters':/[\u004E\u24C3\uFF2E\u01F8\u0143\u00D1\u1E44\u0147\u1E46\u0145\u1E4A\u1E48\u0220\u019D\uA790\uA7A4]/g},
    {'base':'NJ','letters':/[\u01CA]/g},
    {'base':'Nj','letters':/[\u01CB]/g},
    {'base':'O', 'letters':/[\u004F\u24C4\uFF2F\u00D2\u00D3\u00D4\u1ED2\u1ED0\u1ED6\u1ED4\u00D5\u1E4C\u022C\u1E4E\u014C\u1E50\u1E52\u014E\u022E\u0230\u00D6\u022A\u1ECE\u0150\u01D1\u020C\u020E\u01A0\u1EDC\u1EDA\u1EE0\u1EDE\u1EE2\u1ECC\u1ED8\u01EA\u01EC\u00D8\u01FE\u0186\u019F\uA74A\uA74C]/g},
    {'base':'OI','letters':/[\u01A2]/g},
    {'base':'OO','letters':/[\uA74E]/g},
    {'base':'OU','letters':/[\u0222]/g},
    {'base':'P', 'letters':/[\u0050\u24C5\uFF30\u1E54\u1E56\u01A4\u2C63\uA750\uA752\uA754]/g},
    {'base':'Q', 'letters':/[\u0051\u24C6\uFF31\uA756\uA758\u024A]/g},
    {'base':'R', 'letters':/[\u0052\u24C7\uFF32\u0154\u1E58\u0158\u0210\u0212\u1E5A\u1E5C\u0156\u1E5E\u024C\u2C64\uA75A\uA7A6\uA782]/g},
    {'base':'S', 'letters':/[\u0053\u24C8\uFF33\u1E9E\u015A\u1E64\u015C\u1E60\u0160\u1E66\u1E62\u1E68\u0218\u015E\u2C7E\uA7A8\uA784]/g},
    {'base':'T', 'letters':/[\u0054\u24C9\uFF34\u1E6A\u0164\u1E6C\u021A\u0162\u1E70\u1E6E\u0166\u01AC\u01AE\u023E\uA786]/g},
    {'base':'TZ','letters':/[\uA728]/g},
    {'base':'U', 'letters':/[\u0055\u24CA\uFF35\u00D9\u00DA\u00DB\u0168\u1E78\u016A\u1E7A\u016C\u00DC\u01DB\u01D7\u01D5\u01D9\u1EE6\u016E\u0170\u01D3\u0214\u0216\u01AF\u1EEA\u1EE8\u1EEE\u1EEC\u1EF0\u1EE4\u1E72\u0172\u1E76\u1E74\u0244]/g},
    {'base':'V', 'letters':/[\u0056\u24CB\uFF36\u1E7C\u1E7E\u01B2\uA75E\u0245]/g},
    {'base':'VY','letters':/[\uA760]/g},
    {'base':'W', 'letters':/[\u0057\u24CC\uFF37\u1E80\u1E82\u0174\u1E86\u1E84\u1E88\u2C72]/g},
    {'base':'X', 'letters':/[\u0058\u24CD\uFF38\u1E8A\u1E8C]/g},
    {'base':'Y', 'letters':/[\u0059\u24CE\uFF39\u1EF2\u00DD\u0176\u1EF8\u0232\u1E8E\u0178\u1EF6\u1EF4\u01B3\u024E\u1EFE]/g},
    {'base':'Z', 'letters':/[\u005A\u24CF\uFF3A\u0179\u1E90\u017B\u017D\u1E92\u1E94\u01B5\u0224\u2C7F\u2C6B\uA762]/g},
    {'base':'a', 'letters':/[\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250]/g},
    {'base':'aa','letters':/[\uA733]/g},
    {'base':'ae','letters':/[\u00E6\u01FD\u01E3]/g},
    {'base':'ao','letters':/[\uA735]/g},
    {'base':'au','letters':/[\uA737]/g},
    {'base':'av','letters':/[\uA739\uA73B]/g},
    {'base':'ay','letters':/[\uA73D]/g},
    {'base':'b', 'letters':/[\u0062\u24D1\uFF42\u1E03\u1E05\u1E07\u0180\u0183\u0253]/g},
    {'base':'c', 'letters':/[\u0063\u24D2\uFF43\u0107\u0109\u010B\u010D\u00E7\u1E09\u0188\u023C\uA73F\u2184]/g},
    {'base':'d', 'letters':/[\u0064\u24D3\uFF44\u1E0B\u010F\u1E0D\u1E11\u1E13\u1E0F\u0111\u018C\u0256\u0257\uA77A]/g},
    {'base':'dz','letters':/[\u01F3\u01C6]/g},
    {'base':'e', 'letters':/[\u0065\u24D4\uFF45\u00E8\u00E9\u00EA\u1EC1\u1EBF\u1EC5\u1EC3\u1EBD\u0113\u1E15\u1E17\u0115\u0117\u00EB\u1EBB\u011B\u0205\u0207\u1EB9\u1EC7\u0229\u1E1D\u0119\u1E19\u1E1B\u0247\u025B\u01DD]/g},
    {'base':'f', 'letters':/[\u0066\u24D5\uFF46\u1E1F\u0192\uA77C]/g},
    {'base':'g', 'letters':/[\u0067\u24D6\uFF47\u01F5\u011D\u1E21\u011F\u0121\u01E7\u0123\u01E5\u0260\uA7A1\u1D79\uA77F]/g},
    {'base':'h', 'letters':/[\u0068\u24D7\uFF48\u0125\u1E23\u1E27\u021F\u1E25\u1E29\u1E2B\u1E96\u0127\u2C68\u2C76\u0265]/g},
    {'base':'hv','letters':/[\u0195]/g},
    {'base':'i', 'letters':/[\u0069\u24D8\uFF49\u00EC\u00ED\u00EE\u0129\u012B\u012D\u00EF\u1E2F\u1EC9\u01D0\u0209\u020B\u1ECB\u012F\u1E2D\u0268\u0131]/g},
    {'base':'j', 'letters':/[\u006A\u24D9\uFF4A\u0135\u01F0\u0249]/g},
    {'base':'k', 'letters':/[\u006B\u24DA\uFF4B\u1E31\u01E9\u1E33\u0137\u1E35\u0199\u2C6A\uA741\uA743\uA745\uA7A3]/g},
    {'base':'l', 'letters':/[\u006C\u24DB\uFF4C\u0140\u013A\u013E\u1E37\u1E39\u013C\u1E3D\u1E3B\u017F\u0142\u019A\u026B\u2C61\uA749\uA781\uA747]/g},
    {'base':'lj','letters':/[\u01C9]/g},
    {'base':'m', 'letters':/[\u006D\u24DC\uFF4D\u1E3F\u1E41\u1E43\u0271\u026F]/g},
    {'base':'n', 'letters':/[\u006E\u24DD\uFF4E\u01F9\u0144\u00F1\u1E45\u0148\u1E47\u0146\u1E4B\u1E49\u019E\u0272\u0149\uA791\uA7A5]/g},
    {'base':'nj','letters':/[\u01CC]/g},
    {'base':'o', 'letters':/[\u006F\u24DE\uFF4F\u00F2\u00F3\u00F4\u1ED3\u1ED1\u1ED7\u1ED5\u00F5\u1E4D\u022D\u1E4F\u014D\u1E51\u1E53\u014F\u022F\u0231\u00F6\u022B\u1ECF\u0151\u01D2\u020D\u020F\u01A1\u1EDD\u1EDB\u1EE1\u1EDF\u1EE3\u1ECD\u1ED9\u01EB\u01ED\u00F8\u01FF\u0254\uA74B\uA74D\u0275]/g},
    {'base':'oi','letters':/[\u01A3]/g},
    {'base':'ou','letters':/[\u0223]/g},
    {'base':'oo','letters':/[\uA74F]/g},
    {'base':'p','letters':/[\u0070\u24DF\uFF50\u1E55\u1E57\u01A5\u1D7D\uA751\uA753\uA755]/g},
    {'base':'q','letters':/[\u0071\u24E0\uFF51\u024B\uA757\uA759]/g},
    {'base':'r','letters':/[\u0072\u24E1\uFF52\u0155\u1E59\u0159\u0211\u0213\u1E5B\u1E5D\u0157\u1E5F\u024D\u027D\uA75B\uA7A7\uA783]/g},
    {'base':'s','letters':/[\u0073\u24E2\uFF53\u00DF\u015B\u1E65\u015D\u1E61\u0161\u1E67\u1E63\u1E69\u0219\u015F\u023F\uA7A9\uA785\u1E9B]/g},
    {'base':'t','letters':/[\u0074\u24E3\uFF54\u1E6B\u1E97\u0165\u1E6D\u021B\u0163\u1E71\u1E6F\u0167\u01AD\u0288\u2C66\uA787]/g},
    {'base':'tz','letters':/[\uA729]/g},
    {'base':'u','letters':/[\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u00FC\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289]/g},
    {'base':'v','letters':/[\u0076\u24E5\uFF56\u1E7D\u1E7F\u028B\uA75F\u028C]/g},
    {'base':'vy','letters':/[\uA761]/g},
    {'base':'w','letters':/[\u0077\u24E6\uFF57\u1E81\u1E83\u0175\u1E87\u1E85\u1E98\u1E89\u2C73]/g},
    {'base':'x','letters':/[\u0078\u24E7\uFF58\u1E8B\u1E8D]/g},
    {'base':'y','letters':/[\u0079\u24E8\uFF59\u1EF3\u00FD\u0177\u1EF9\u0233\u1E8F\u00FF\u1EF7\u1E99\u1EF5\u01B4\u024F\u1EFF]/g},
    {'base':'z','letters':/[\u007A\u24E9\uFF5A\u017A\u1E91\u017C\u017E\u1E93\u1E95\u01B6\u0225\u0240\u2C6C\uA763]/g}
  ];
  for(var i=0; i<defaultDiacriticsRemovalMap.length; i++) {
    str = str.replace(defaultDiacriticsRemovalMap[i].letters, defaultDiacriticsRemovalMap[i].base);
  }
  return str;
}

function get_filters() {
  var sexe_filter, sexe_filter_value, category_filter, category_filter_value, name_filter, name_filter_value;
  sexe_filter = document.getElementById("filterSexe")
  sexe_filter_value = sexe_filter != null ? sexe_filter.value.toUpperCase() : "";
  category_filter = document.getElementById("filterCategory");
  category_filter_value = category_filter != null ? category_filter.value.toUpperCase() : "";
  name_filter = document.getElementById("kapp10-filter");
  name_filter_value = name_filter != null ? removeDiacritics(name_filter.value).toUpperCase() : "";
  return {sexe_filter: sexe_filter_value, category_filter: category_filter_value, name_filter: name_filter_value};
}

function display_filtered_participants(filters, tr, i) {
  var sexe_filter_ok = 0, category_filter_ok = 0, name_filter_ok = 0, search_name = null, search_sexe = null, search_category = null;
  var name_value = /data-search="(.*?)"/g.exec(tr[i]);
  var sexe_value = /data-sexe-search="(.*?)"/g.exec(tr[i]);
  var category_value = /data-category-search="(.*?)"/g.exec(tr[i]);
  var bib_value = /data-bib-search="(.*?)"/g.exec(tr[i]);
  if (name_value && name_value[1])
    search_name = name_value[1];
  if (sexe_value && sexe_value[1])
    search_sexe = sexe_value[1];
  if (category_value && category_value[1])
    search_category = category_value[1];
  if (search_sexe) {
    if (filters.sexe_filter == "ALL" || filters.sexe_filter == "" || search_sexe.indexOf(filters.sexe_filter) > -1)
      sexe_filter_ok = 0;
    else
      sexe_filter_ok = -1;
  } else if ((!search_sexe || search_sexe == "") && $('th[name=sex]').length != 0) {
    if (filters.sexe_filter == "ALL" || filters.sexe_filter == "")
      sexe_filter_ok = 0;
    else
      sexe_filter_ok = -1;
  }
  if (search_category) {
    if (filters.category_filter == "ALL" || filters.category_filter == "" || search_category.toUpperCase().indexOf(filters.category_filter) > -1)
      category_filter_ok = 0;
    else
      category_filter_ok = -1;
  } else if ((!search_category || search_category == "") && $('th[name=categ]').length != 0) {
    if (filters.category_filter == "ALL" || filters.category_filter == "")
      category_filter_ok = 0;
    else
      category_filter_ok = -1;
  }
  if (search_name) {
    if (bib_value && bib_value[1])
      var bib = bib_value[1];
    else
      var bib = "";
    if (filters.name_filter == "" || search_name.indexOf(filters.name_filter) > -1 || bib.indexOf(filters.name_filter) > -1)
      name_filter_ok = 0;
    else
      name_filter_ok = -1;
  }
  if (sexe_filter_ok > -1 && category_filter_ok > -1 && name_filter_ok > -1)
    return tr[i];
  return "";
}

function display_no_participants(filters) {
  if (count == 0) {
    if (mobileDevice() == true) {
      $(currentSelectedWrapper).css("height", "60px");
    }
    else {
      $(currentSelectedSection + " .noResults")[0].style.display = "";
    }
  } else {
    $(currentSelectedSection + " .noResults")[0].style.display = "none";
    if (mobileDevice() == true) {
      $(currentSelectedWrapper).css("height", "545px");
    }
  }
}

function reset_participant_filter() {
  input = document.getElementById("kapp10-filter");
  input.value = "";
  participant_filter();
}

function participant_filter() {
  var input, tr, i, n, index, reset_filter, filters, linesToDisplay = "", lines, lineIndexed;
  filters = get_filters();
  input = document.getElementById("kapp10-filter");
  reset_filter = document.getElementById("closingCircleResearch");
  input.value == "" ? reset_filter.style.visibility = "hidden" : reset_filter.style.visibility = "visible";
  if (typeof edition_lines === 'undefined')
    return ;
  tr = edition_lines[currentSelectedSection];
  n = tr.length;
  index = 1;
  for (i = 0; i < n; i++) {
    lineFiltered = display_filtered_participants(filters, tr, i);
    if (lineFiltered != '') {
      var id = lineFiltered.match(/<td class="center fixedColumn">(.*)<\/td>/)[1];
      var oldTd = '<td class="center fixedColumn">' + id + '</td>';
      var newTd = '<td class="center fixedColumn">' + index + '</td>';
      lineIndexed = lineFiltered.replace(oldTd, newTd);
      index++;
      linesToDisplay += lineIndexed;
    }
  }
  $(currentSelectedSection + ' .results tbody')[0].innerHTML = linesToDisplay;
  lines = $(currentSelectedSection + ' tbody tr');
  filteredLines = [];
  for (var i = 0; i < lines.length; i++) {
    filteredLines[i] = String(lines[i].outerHTML);
  }
  $('#pagination_container').twbsPagination('destroy');
  setPagination();
  setLineHeight();
  update_participants_style(filters);
}

/*
 **	Update widget style
 */

function resize_results_section(count) {
  var tr = $(currentSelectedSection + " .results tbody tr")[0];
  var trHeight = tr ? setLineHeight() + 2 : 0;
  var linesHeight = count * trHeight + 60;
  if (linesHeight < resultsContainerHeight) {
    $("section").css("height", "auto");
    $("#resultsContainer").css("height", "auto");
    if (mobileDevice() == true) {
      $(currentSelectedWrapper).css("height", "auto");
    }
  } else {
    $("section").css("height", "545px");
    $("#resultsContainer").css("height", "545px");
  }
}

function update_categories(filters) {
  var categoriesForSelected, categoryFilterTag, optionsForCategories;

  categoriesForSelected = categoriesSorted[0][selectedSectionId.replace(/(tab_)/, '')][filters.sexe_filter];
  if (categoriesForSelected) {
    categoryFilterTag = document.getElementById("filterCategory");
    if (categoryFilterTag == null) {
      return ;
    }
    optionsForCategories = '<option value="all">Toutes les cat&eacute;gories</option>';
    for (var i = 0; i < categoriesForSelected.length; i++) {
      if (categoriesForSelected[i] != null) {
        optionsForCategories += '<option value="'+categoriesForSelected[i]+'" ';
        if (categoriesForSelected[i].toUpperCase() == filters.category_filter) {
          optionsForCategories += 'selected';
        }
        optionsForCategories += '>'+categoriesForSelected[i]+'</option>';
      }
    }
    categoryFilterTag.innerHTML = optionsForCategories;
  }
}

function display_line_color_styles() {
  var tr, n, fixedColumn,fixedColumnWithMargin;
  count = 0;
  tr = $(currentSelectedSection + " table.results tbody tr");
  n = tr.length;
  for (var i = 0; i < n ; i++) {
    if (tr[i].style.display != "none") {
      fixedColumn = tr[i].getElementsByClassName("fixedColumn");
      fixedColumnWithMargin = tr[i].getElementsByClassName("fixedColumnWithMargin");
      if (count % 2 == 0) {
        tr[i].style.backgroundColor = "white";
        if (fixedColumn[0] && fixedColumnWithMargin[0]) {
          fixedColumn[0].style.backgroundColor = "white";
          fixedColumnWithMargin[0].style.backgroundColor = "white";
        }
      } else {
        tr[i].style.backgroundColor = "#EEEEEE";
        if (fixedColumn[0] && fixedColumnWithMargin[0]) {
          fixedColumn[0].style.backgroundColor = "#EEEEEE";
          fixedColumnWithMargin[0].style.backgroundColor = "#EEEEEE";
        }
      }
      count++;
    }
  }
}

function update_participants_style(filters) {
  update_categories(filters);
  display_line_color_styles();
  display_no_participants(filters);
  resize_results_section(count);
  resizeTableHead();
}

/*
 ** VERTCIAL & HORIZONTAL SCROLLING
 */

function mobileDevice() {
  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
    return true;
  }
  return false;
}

function showArrows() {
  $('.scrollLeftContainer').css("display", "flex");
  $('.scrollRightContainer').css("display", "flex");
}

function hideArrows() {
  $('.scrollLeftContainer').hide();
  $('.scrollRightContainer').hide();
}

function displayArrowOnScrollPosition() {
  var $selectedWrapper = $(currentSelectedWrapper);
  if ($selectedWrapper.scrollLeft() == 0) {
    $('.scrollLeftContainer').hide();
  } else if (($selectedWrapper.scrollLeft() + $selectedWrapper[0].clientWidth) == $selectedWrapper[0].scrollWidth) {
    $('.scrollRightContainer').hide();
  }
}
/*
 ** VERTCIAL & HORIZONTAL SCROLLING
 */

function mobileDevice() {
  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
    return true;
  }
  return false;
}

function showArrows() {
  $('.scrollLeftContainer').css("display", "flex");
  $('.scrollRightContainer').css("display", "flex");
}

function hideArrows() {
  $('.scrollLeftContainer').hide();
  $('.scrollRightContainer').hide();
}

function displayArrowOnScrollPosition() {
  var $selectedWrapper = $(currentSelectedWrapper);
  if ($selectedWrapper.scrollLeft() == 0) {
    $('.scrollLeftContainer').hide();
  } else if (($selectedWrapper.scrollLeft() + $selectedWrapper[0].clientWidth) == $selectedWrapper[0].scrollWidth) {
    $('.scrollRightContainer').hide();
  }
}

/* Update results container when changing race for scrolling and style */
function updateSelectedRaces() {
  var filters = get_filters();
  selectedSectionId = $("input:radio.tab:checked")[0].id;
  var sectionId = selectedSectionId.replace(/(tab_)/, 'content_');
  currentSelectedSection = "#" + sectionId;
  currentSelectedWrapper = '#tableWrapper_'+selectedSectionId;
  var $currentWrapper = $(currentSelectedWrapper);
  var pos = $currentWrapper.scrollLeft();
  $(".headTableWrapper").scrollLeft(pos);
  if ($currentWrapper[0].clientWidth < $currentWrapper[0].scrollWidth) {
    showArrows();
    displayArrowOnScrollPosition();
  }
  if (typeof edition_lines === 'undefined') {
    return;
  }

  if (filters.category_filter == "ALL" && filters.sexe_filter == "ALL" && filters.name_filter == "") {
    filteredLines = edition_lines[currentSelectedSection];
    $('#pagination_container').twbsPagination('destroy');
    setPagination();
  } else {
    participant_filter();
  }
  var $table = $(currentSelectedSection + ' table.results');
  if ($table.hasClass("floatThead-table") == false) {
    $table.floatThead({
      scrollContainer: function($table){
        return $table.closest("div");
      }
    });
  }
}

function scrollTable(event) {
  var $currentWrapper = $(currentSelectedWrapper);
  var scrollingHeader = $(".headTableWrapper");
  if (event.data.direction == 'left') {
    var pos = $currentWrapper.scrollLeft() - 55;
    var posHeader = scrollingHeader.scrollLeft() - 55;
  } else if (event.data.direction == 'right') {
    var pos = $currentWrapper.scrollLeft() + 55;
    var posHeader = scrollingHeader.scrollLeft() + 55;
  }
  $currentWrapper.animate( { scrollLeft: pos }, 300, 'swing' );
  scrollingHeader.animate( { scrollLeft: posHeader }, 300, 'swing' );
}

function onTableWrapperScroll() {
  var pos = $(currentSelectedWrapper).scrollLeft();
  $(".headTableWrapper").scrollLeft(pos);
  showArrows();
  displayArrowOnScrollPosition();
}

function displayScrollingBar(scrollHeight) {
  if (mobileDevice() == true) {
    return;
  }
  var $currentScrollbar = $("#scrollbar_" + currentSelectedSection.replace(/(#content_)/, ''));
  var currentSection = $(currentSelectedSection)[0];
  if (currentSection.clientHeight >= currentSection.scrollHeight) {
    $currentScrollbar.hide();
  } else {
    $currentScrollbar.show();
  }
}

function resizeTableHead() {
  var i, referenceCells;
  referenceCells = $(currentSelectedSection + " table.results tbody tr:visible:first td");
  if (count == 0) {
    return ;
  }
  i = mobileDevice() == true ? 0 : 2;
  for (i; i < referenceCells.length; i++) {
    var cellWidth = referenceCells[i].offsetWidth;
    if (referenceCells[i].style.display != "none") {
      $targetCells[i].style.minWidth = cellWidth;
      $targetCells[i].style.width = cellWidth;
    }
  }
}

function setScrollbarThumbHeight() {
  var containerHeight = $(currentSelectedSection)[0].clientHeight;
  var containerTotalHeight = $(currentSelectedSection)[0].scrollHeight;
  var maxPos = 0;
  while (maxPos + containerHeight <= containerTotalHeight) {
    maxPos += 14;
  }
  var containerMaxRatio = maxPos / (containerTotalHeight / containerHeight);
  var thumbHeight = containerHeight - containerMaxRatio;
  var currentScrollbarThumb = "#scrollbarThumb_" + selectedSectionId.replace(/(tab_)/, '');
  $(currentScrollbarThumb).css("height", thumbHeight+'px');
}

function moveScrollThumb(pos) {
  var containerHeight = $(currentSelectedSection)[0].clientHeight;
  var containerTotalHeight = $(currentSelectedSection)[0].scrollHeight;
  var currentScrollbarThumb = "#scrollbarThumb_" + selectedSectionId.replace(/(tab_)/, '');
  var topPos = parseInt($(currentScrollbarThumb).css("top").replace(/[^-\d\.]/g, ''));
  topPos = prevPos < pos ? topPos + 2 : topPos - 2;
  var containerRatio = pos / (containerTotalHeight / containerHeight);
  if (containerRatio >= 0 && topPos <= containerHeight) {
    $(currentScrollbarThumb).css("top", containerRatio + 'px');
  }
  prevPos = pos;
}

function displaySection() {
  if ($('#mainResultsContent')) {
    $('#mainResultsContent').css('visibility', 'visible');
  } if ($('.loading')) {
    $('.loading').hide();
  }
}

function getTableContent(page, currentSelectedSection) {
  var start, end, lines, linesToDisplay = "";
  start = ((page - 1) * 500);
  end = start + 500;
  lines = filteredLines.slice(start, end);
  for (var i = 0; i < lines.length; i++) {
    linesToDisplay += lines[i];
  }
  return linesToDisplay;
}

function displaySectionContent(page) {
  var content = getTableContent(page, currentSelectedSection);
  $(currentSelectedSection + ' .results tbody')[0].innerHTML = content;
  setLineHeight();
  displayScrollingBar(0);
  setScrollbarThumbHeight();
  var currentScrollbarThumb = "#scrollbarThumb_" + selectedSectionId.replace(/(tab_)/, '');
  $(currentScrollbarThumb).css('top', '0px');
  $(currentSelectedSection).scrollTop(0);
}

function setPagination() {
  var nbLines, nbPages;
  if (typeof filteredLines === 'undefined') {
    if (typeof edition_lines !== 'undefined') {
      filteredLines = edition_lines[currentSelectedSection];
    }
    else
      filteredLines = [];
  }
  nbLines = filteredLines.length;
  nbPages = Math.ceil(nbLines / 500);
  if (nbPages > 1) {
    $('#pagination_container').show();
    $('#pagination_container').twbsPagination({
      totalPages: nbPages,
      visiblePages: 4,
      hideOnlyOnePage: true,
      last: '>>',
      first: '<<',
      onPageClick: function (event, page) {
        displaySectionContent(page);
      }
    });
  } else {
    $('#pagination_container').hide();
    displaySectionContent(1);
  }

}

function setLineHeight() {
  var returnedMaxLength = 0;
  if (typeof longestName !== 'undefined') {
    var labels = $('label').toArray();
    labels.forEach(function(element) {
      var label = element.innerHTML;
      var maxLength = longestName[0][label] + 10;
      if (maxLength < 30) {
        maxLength = 30;
      }
      var section = "#" + element.getAttribute('for').replace(/(tab_)/, 'content_');
      if (section == currentSelectedSection)
        returnedMaxLength = maxLength;
      $(section + ' tbody tr').css('height', maxLength + 'px');
      $(section + ' td.fixedColumn').css('height', maxLength);
      $(section + ' td.fixedColumnWithMargin').css('height', maxLength);
    });
    return returnedMaxLength;
  }
  return 0;
}

$(document).ready(function(){
  var filters = get_filters();
  selectedSectionId = $("input:radio.tab:checked")[0].id;
  currentSelectedWrapper = '#tableWrapper_'+selectedSectionId;
  currentSelectedSection = "#" + selectedSectionId.replace(/(tab_)/, 'content_');
  var $currentWrapper = $(currentSelectedWrapper);
  var sections = $("section");
  var allSections = "#" + selectedSectionId.replace(/(tab_)/, 'content_');
  update_categories(filters);
  for (var i = 0; i < sections.length; i++) {
    allSections += ", #" + $(sections[i]).attr('id');
  }
  var scrollbars = $(".scrollbar-thumb");
  var scrollbarThumbs = "#scrollbarThumb_" + selectedSectionId.replace(/(tab_)/, '');
  for (var i = 1; i < scrollbars.length; i++) {
    scrollbarThumbs += ", #" + $(scrollbars[i]).attr('id');
  }
  prevPos = 0;
  onSectionDiv = 0;
  onContainerClick = 0;
  count = 1;
  if (mobileDevice() == true) {
    var $table = $(currentSelectedSection + ' table.results');
    $(".desktop-only").hide();
    $(".mobileOnly").show();
    $("div").removeClass("tableWrapper");
    $("#resultsHead th, .results td").removeClass("fixedColumn fixedColumnWithMargin");
    $("table.results tbody td").addClass("mobileView");
    $("table.results tbody").css("height", "545px");
    $("table.results").closest("div").css({"height" : "545px",
      "overflow" : "auto",
      "margin-top" : "5px"});
    $table.floatThead({
      scrollContainer: function($table){
        return $table.closest("div");
      }
    });
    $targetCells = $("table.results thead th");
  } else {
    $(".desktop-only").show();
    $(".mobileOnly").hide();
    $targetCells = $("#resultsHead th");
  }
  resizeTableHead();
  if (mobileDevice() == false) {
    $('#resultsContainer').height('545px');
  }
  resultsContainerHeight = $('#resultsContainer').height();
  setPagination();
  if ($currentWrapper[0].clientWidth >= $currentWrapper[0].scrollWidth) {
    hideArrows();
  }
  else {
    displayArrowOnScrollPosition();
  }
  displaySection();

  /* Events */
  $(window).on('resize', function(){
    var currentWrapper = $(currentSelectedWrapper)[0];
    if (currentWrapper.clientWidth < currentWrapper.scrollWidth) {
      if (mobileDevice() == false) {
        showArrows();
      }
    }
    if (currentWrapper.clientWidth >= currentWrapper.scrollWidth) {
      hideArrows();
    }
    displayArrowOnScrollPosition();
    resizeTableHead();
  });

  $(document).mouseup(function(e)  {
    var $container = $(currentSelectedSection);
    if (!$container.is(e.target) && $container.has(e.target).length === 0)  {
      onContainerClick = 0;
    } else {
      onContainerClick = 1;
    }
  });

  $("section").on("mouseenter mouseleave", function(e){
    if (e.type == "mouseenter") {
      onSectionDiv = 1;
    } else {
      onSectionDiv = 0;
    }
  });

  $(allSections).bind('mousewheel wheel', function(e) {
    e.preventDefault();
    if (onSectionDiv == 1) {
      var pos = $(currentSelectedSection).scrollTop();
      wheelDirection = e.originalEvent.deltaY;
      wheelHorizontalDirection = e.originalEvent.deltaX;
      pos = wheelDirection > 0 ? pos + 14 : pos - 14;
      var containerHeight = $(currentSelectedSection)[0].clientHeight;
      var containerTotalHeight = $(currentSelectedSection)[0].scrollHeight;
      if (wheelHorizontalDirection == 0 || wheelHorizontalDirection == -0) {
        if (pos + containerHeight <= containerTotalHeight) {
          $(currentSelectedSection).scrollTop(pos);
          moveScrollThumb(pos);
        } else {
          $(currentSelectedSection).scrollTop(containerTotalHeight);
          moveScrollThumb(pos);
        }
      }
      if (wheelHorizontalDirection < 0 || wheelHorizontalDirection > 0) {
        var $currentWrapper = $(currentSelectedWrapper);
        var horizontalPos = $currentWrapper.scrollLeft();
        if (wheelHorizontalDirection < 0) {
          $currentWrapper.scrollLeft(horizontalPos - 2);
          $(".headTableWrapper").scrollLeft(horizontalPos - 2);
        }
        if (wheelHorizontalDirection > 0 ) {
          $currentWrapper.scrollLeft(horizontalPos + 2);
          $(".headTableWrapper").scrollLeft(horizontalPos + 2);
        }
      }
    }
  });

  $('.scrollRightContainer').on('click', { direction: 'right' }, scrollTable);

  $('.scrollLeftContainer').on('click', { direction: 'left' }, scrollTable);

  $(document).on("keydown", function(e) {
    var arrowKeys = [37, 38, 39, 40];
    if (onContainerClick == 1 && $.inArray(e.which, arrowKeys) != -1) {
      e.preventDefault();
      var verticalPos = $(currentSelectedSection).scrollTop();
      var horizontalPos = $(currentSelectedWrapper).scrollLeft();
      var containerHeight = $(currentSelectedSection)[0].clientHeight;
      var containerTotalHeight = $(currentSelectedSection)[0].scrollHeight;
      switch (e.which) {
        case 37:
          if (horizontalPos - 4 >= 0) {
            $(currentSelectedWrapper).scrollLeft(horizontalPos - 4);
            $(".headTableWrapper").scrollLeft(horizontalPos - 4);
          } else {
            $(currentSelectedWrapper).scrollLeft(0);
            $(".headTableWrapper").scrollLeft(0);
          }
          break;
        case 38:
          if (verticalPos - 8 >= 0) {
            $(currentSelectedSection).scrollTop(verticalPos - 8);
            moveScrollThumb(verticalPos - 8);
          }
          break;
        case 39:
          if (horizontalPos + 4 + $(currentSelectedWrapper)[0].clientWidth <= $(currentSelectedWrapper)[0].scrollWidth) {
            $(currentSelectedWrapper).scrollLeft(horizontalPos + 4);
            $(".headTableWrapper").scrollLeft(horizontalPos + 4);
          } else {
            $(currentSelectedWrapper).scrollLeft($(currentSelectedWrapper)[0].scrollWidth);
            $(".headTableWrapper").scrollLeft($(currentSelectedWrapper)[0].scrollWidth);
          }
          break;
        case 40:
          if (verticalPos + containerHeight < containerTotalHeight) {
            $(currentSelectedSection).scrollTop(verticalPos + 8);
            moveScrollThumb(verticalPos + 8);
          }
          break;
      }
    }
  });

  $(scrollbarThumbs).draggable({
    containment: "parent",
    drag: function( event, ui ) {
      var topPosition = ui.position.top;
      var containerHeight = $(currentSelectedSection)[0].clientHeight;
      var containerTotalHeight = $(currentSelectedSection)[0].scrollHeight;
      var pos = (containerTotalHeight / containerHeight) * topPosition;
      $(currentSelectedSection).scrollTop(pos);
    }
  });
});


/*
 **	Scroll table pluging on mobile
 */
/* @preserve jQuery.floatThead 2.0.3 - http://mkoryak.github.io/floatThead/ - Copyright (c) 2012 - 2017 Misha Koryak **/
!function(t){function e(t,e){if(8==f){var o=v.width(),n=s.debounce(function(){var t=v.width();o!=t&&(o=t,e())},1);v.on(t,n)}else v.on(t,s.debounce(e,1))}function o(e){var o=e[0],n=o.parentElement;do{var r=window.getComputedStyle(n).getPropertyValue("overflow");if("visible"!=r)break}while(n=n.parentElement);return t(n==document.body?[]:n)}function n(t){window&&window.console&&window.console.error&&window.console.error("jQuery.floatThead: "+t)}function r(t){var e=t.getBoundingClientRect();return e.width||e.right-e.left}function a(){var t=document.createElement("scrolltester");t.style.cssText="width:100px;height:100px;overflow:scroll!important;position:absolute;top:-9999px;display:block",document.body.appendChild(t);var e=t.offsetWidth-t.clientWidth;return document.body.removeChild(t),e}function i(t){if(t.dataTableSettings)for(var e=0;e<t.dataTableSettings.length;e++){var o=t.dataTableSettings[e].nTable;if(t[0]==o)return!0}return!1}function l(t,e,o){var n=o?"outerWidth":"width";if(p&&t.css("max-width")){var r=0;o&&(r+=parseInt(t.css("borderLeft"),10),r+=parseInt(t.css("borderRight"),10));for(var a=0;a<e.length;a++)r+=e.get(a).offsetWidth;return r}return t[n]()}t.floatThead=t.floatThead||{},t.floatThead.defaults={headerCellSelector:"tr:visible:first>*:visible",zIndex:1001,position:"auto",top:0,bottom:0,scrollContainer:function(){return t([])},responsiveContainer:function(){return t([])},getSizingRow:function(t){return t.find("tbody tr:visible:first>*:visible")},floatTableClass:"floatThead-table",floatWrapperClass:"floatThead-wrapper",floatContainerClass:"floatThead-container",copyTableClass:!0,autoReflow:!1,debug:!1,support:{bootstrap:!0,datatables:!0,jqueryUI:!0,perfectScrollbar:!0}};var s=window._||function(){var e={},o=Object.prototype.hasOwnProperty,n=["Arguments","Function","String","Number","Date","RegExp"];e.has=function(t,e){return o.call(t,e)},e.keys=Object.keys||function(t){if(t!==Object(t))throw new TypeError("Invalid object");var o=[];for(var n in t)e.has(t,n)&&o.push(n);return o};var r=0;return e.uniqueId=function(t){var e=++r+"";return t?t+e:e},t.each(n,function(){var t=this;e["is"+t]=function(e){return Object.prototype.toString.call(e)=="[object "+t+"]"}}),e.debounce=function(t,e,o){var n,r,a,i,l;return function(){a=this,r=arguments,i=new Date;var s=function(){var d=new Date-i;e>d?n=setTimeout(s,e-d):(n=null,o||(l=t.apply(a,r)))},d=o&&!n;return n||(n=setTimeout(s,e)),d&&(l=t.apply(a,r)),l}},e}(),d="undefined"!=typeof MutationObserver,f=function(){for(var t=3,e=document.createElement("b"),o=e.all||[];t=1+t,e.innerHTML="<!--[if gt IE "+t+"]><i><![endif]-->",o[0];);return t>4?t:document.documentMode}(),c=/Gecko\//.test(navigator.userAgent),u=/WebKit\//.test(navigator.userAgent);f||c||u||(f=11);var p=function(){if(u){var e=t("<div>").css("width",0).append(t("<table>").css("max-width","100%").append(t("<tr>").append(t("<th>").append(t("<div>").css("min-width",100).text("X")))));t("body").append(e);var o=0==e.find("table").width();return e.remove(),o}return!1},h=!c&&!f,v=t(window);if(!window.matchMedia){var b=window.onbeforeprint,w=window.onafterprint;window.onbeforeprint=function(){b&&b(),v.triggerHandler("beforeprint")},window.onafterprint=function(){w&&w(),v.triggerHandler("afterprint")}}t.fn.floatThead=function(c){if(c=c||{},8>f)return this;var b=null;if(s.isFunction(p)&&(p=p()),s.isString(c)){var w=c,g=Array.prototype.slice.call(arguments,1),m=this;return this.filter("table").each(function(){var e=t(this),o=e.data("floatThead-lazy");o&&e.floatThead(o);var n=e.data("floatThead-attached");if(n&&s.isFunction(n[w])){var r=n[w].apply(this,g);void 0!==r&&(m=r)}}),m}var y=t.extend({},t.floatThead.defaults||{},c);if(t.each(c,function(e){e in t.floatThead.defaults||!y.debug||n("Used ["+e+"] key to init plugin, but that param is not an option for the plugin. Valid options are: "+s.keys(t.floatThead.defaults).join(", "))}),y.debug){var T=t.fn.jquery.split(".");1==parseInt(T[0],10)&&parseInt(T[1],10)<=7&&n("jQuery version "+t.fn.jquery+" detected! This plugin supports 1.8 or better, or 1.7.x with jQuery UI 1.8.24 -> http://jqueryui.com/resources/download/jquery-ui-1.8.24.zip")}return this.filter(":not(."+y.floatTableClass+")").each(function(){function c(t){return t+".fth-"+R+".floatTHead"}function p(){var e=0;if(k.children("tr:visible").each(function(){e+=t(this).outerHeight(!0)}),"collapse"==M.css("border-collapse")){var o=parseInt(M.css("border-top-width"),10),n=parseInt(M.find("thead tr:first").find(">*:first").css("border-top-width"),10);o>n&&(e-=o/2)}st.outerHeight(e),dt.outerHeight(e)}function w(){var t=l(M,ut,!0),e=V?P:U,o=e.width()||t,n="hidden"!=e.css("overflow-y")?o-N.vertical:o;if(at.width(n),G){var r=100*t/n;tt.css("width",r+"%")}else tt.outerWidth(t)}function g(){D=(s.isFunction(y.top)?y.top(M):y.top)||0,O=(s.isFunction(y.bottom)?y.bottom(M):y.bottom)||0}function m(){var e,o=k.find(y.headerCellSelector);if(nt?e=ot.find("col").length:(e=0,o.each(function(){e+=parseInt(t(this).attr("colspan")||1,10)})),e!=Q){Q=e;for(var n,r=[],a=[],i=[],l=0;e>l;l++)n=o.eq(l).text(),r.push('<th class="floatThead-col" aria-label="'+n+'"/>'),a.push("<col/>"),i.push(t("<fthtd>").css({display:"table-cell",height:0,width:"auto"}));a=a.join(""),r=r.join(""),h&&(rt.empty(),rt.append(i),ut=rt.find("fthtd")),st.html(r),dt=st.find("th"),nt||ot.html(a),ft=ot.find("col"),et.html(a),ct=et.find("col")}return e}function T(){if(!F){if(F=!0,X){var t=l(M,ut,!0),e=J.width();t>e&&M.css("minWidth",t)}M.css(vt),tt.css(vt),tt.append(k),E.before(lt),p()}}function C(){F&&(F=!1,X&&M.width(wt),lt.detach(),M.prepend(k),M.css(bt),tt.css(bt),M.css("minWidth",gt),M.css("minWidth",l(M,ut)))}function x(t){mt!=t&&(mt=t,M.triggerHandler("floatThead",[t,at]))}function j(t){X!=t&&(X=t,at.css({position:X?"absolute":"fixed"}))}function S(t,e,o,n){return h?o:n?y.getSizingRow(t,e,o):e}function z(){var t,e=m();return function(){var o=at.scrollLeft();ft=ot.find("col");var n=S(M,ft,ut,f);if(n.length==e&&e>0){if(!nt)for(t=0;e>t;t++)ft.eq(t).css("width","");C();var a=[];for(t=0;e>t;t++)a[t]=r(n.get(t));for(t=0;e>t;t++)ct.eq(t).width(a[t]),ft.eq(t).width(a[t]);T()}else tt.append(k),M.css(bt),tt.css(bt),p();at.scrollLeft(o),M.triggerHandler("reflowed",[at])}}function I(t){var e=U.css("border-"+t+"-width"),o=0;return e&&~e.indexOf("px")&&(o=parseInt(e,10)),o}function L(){return"auto"==P.css("overflow-x")}function W(){var t,e=U.scrollTop(),o=0,n=B?Y.outerHeight(!0):0,r=K?n:-n,a=at.height(),i=M.offset(),l=0,s=0;if(G){var d=U.offset();o=i.top-d.top+e,B&&K&&(o+=n),l=I("left"),s=I("top"),o-=s}else t=i.top-D-a+O+N.horizontal;var f=v.scrollTop(),c=v.scrollLeft(),p=function(){return(L()?P:U).scrollLeft()||0},h=p();return function(d){V=L();var b=M[0].offsetWidth<=0&&M[0].offsetHeight<=0;if(!b&&it)return it=!1,setTimeout(function(){M.triggerHandler("reflow")},1),null;if(b&&(it=!0,!X))return null;if("windowScroll"==d)f=v.scrollTop(),c=v.scrollLeft();else if("containerScroll"==d)if(P.length){if(!V)return;h=P.scrollLeft()}else e=U.scrollTop(),h=U.scrollLeft();else"init"!=d&&(f=v.scrollTop(),c=v.scrollLeft(),e=U.scrollTop(),h=p());if(!u||!(0>f||0>c)){if(Z)j("windowScrollDone"==d?!0:!1);else if("windowScrollDone"==d)return null;i=M.offset(),B&&K&&(i.top+=n);var w,g,m=M.outerHeight();if(G&&X){if(o>=e){var y=o-e+s;w=y>0?y:0,x(!1)}else w=_?s:e,x(!0);g=l}else!G&&X?(f>t+m+r?w=m-a+r:i.top>=f+D?(w=0,C(),x(!1)):(w=D+f-i.top+o+(K?n:0),T(),x(!0)),g=h):G&&!X?(o>e||e-o>m?(w=i.top-f,C(),x(!1)):(w=i.top+e-f-o,T(),x(!0)),g=i.left+h-c):G||X||(f>t+m+r?w=m+D-f+t+r:i.top>f+D?(w=i.top-f,T(),x(!1)):(w=D,x(!0)),g=i.left+h-c);return{top:Math.round(w),left:Math.round(g)}}}}function H(){var t=null,e=null,o=null;return function(n,r,a){if(null!=n&&(t!=n.top||e!=n.left)){if(8===f)at.css({top:n.top,left:n.left});else{var i="translateX("+n.left+"px) translateY("+n.top+"px)";at.css({"-webkit-transform":i,"-moz-transform":i,"-ms-transform":i,"-o-transform":i,transform:i,top:0,left:0})}t=n.top,e=n.left}r&&w(),a&&p();var l=(V?P:U).scrollLeft();X&&o==l||(at.scrollLeft(l),o=l)}}function q(){if(U.length)if(y.support&&y.support.perfectScrollbar&&U.data().perfectScrollbar)N={horizontal:0,vertical:0};else{if("scroll"==U.css("overflow-x"))N.horizontal=A;else{var t=U.width(),e=l(M,ut),o=r>n?A:0;N.horizontal=e>t-o?A:0}if("scroll"==U.css("overflow-y"))N.vertical=A;else{var n=U.height(),r=M.height(),a=e>t?A:0;N.vertical=r>n-a?A:0}}}var R=s.uniqueId(),M=t(this);if(M.data("floatThead-attached"))return!0;if(!M.is("table"))throw new Error('jQuery.floatThead must be run on a table element. ex: $("table").floatThead();');d=y.autoReflow&&d;var k=M.children("thead:first"),E=M.children("tbody:first");if(0==k.length||0==E.length)return y.debug&&n(0==k.length?"The thead element is missing.":"The tbody element is missing."),M.data("floatThead-lazy",y),void M.unbind("reflow").one("reflow",function(){M.floatThead(y)});M.data("floatThead-lazy")&&M.unbind("reflow"),M.data("floatThead-lazy",!1);var D,O,F=!0,N={vertical:0,horizontal:0},A=a(),Q=0;y.scrollContainer===!0&&(y.scrollContainer=o);var U=y.scrollContainer(M)||t([]),G=U.length>0,P=G?t([]):y.responsiveContainer(M)||t([]),V=L(),X=null;"auto"==y.position?X=null:"fixed"==y.position?X=!1:"absolute"==y.position?X=!0:y.debug&&n('Invalid value given to "position" option, valid is "fixed", "absolute" and "auto". You passed: ',y.position),null==X&&(X=G);var Y=M.find("caption"),B=1==Y.length;if(B)var K="top"===(Y.css("caption-side")||Y.attr("align")||"top");var $=t("<fthfoot>").css({display:"table-footer-group","border-spacing":0,height:0,"border-collapse":"collapse",visibility:"hidden"}),_=!1,J=t([]),Z=9>=f&&!G&&X,tt=t("<table/>"),et=t("<colgroup/>"),ot=M.children("colgroup:first"),nt=!0;0==ot.length&&(ot=t("<colgroup/>"),nt=!1);var rt=t("<fthtr>").css({display:"table-row","border-spacing":0,height:0,"border-collapse":"collapse"}),at=t("<div>").css("overflow","hidden").attr("aria-hidden","true"),it=!1,lt=t("<thead/>"),st=t('<tr class="size-row" aria-hidden="true"/>'),dt=t([]),ft=t([]),ct=t([]),ut=t([]);lt.append(st),M.prepend(ot),h&&($.append(rt),M.append($)),tt.append(et),at.append(tt),y.copyTableClass&&tt.attr("class",M.attr("class")),tt.attr({cellpadding:M.attr("cellpadding"),cellspacing:M.attr("cellspacing"),border:M.attr("border")});var pt=M.css("display");if(tt.css({borderCollapse:M.css("borderCollapse"),border:M.css("border"),display:pt}),G||tt.css("width","auto"),"none"==pt&&(it=!0),tt.addClass(y.floatTableClass).css({margin:0,"border-bottom-width":0}),X){var ht=function(e,o){var n=e.css("position"),r="relative"==n||"absolute"==n,a=e;if(!r||o){var i={paddingLeft:e.css("paddingLeft"),paddingRight:e.css("paddingRight")};at.css(i),a=e.data("floatThead-containerWrap")||e.wrap(t("<div>").addClass(y.floatWrapperClass).css({position:"relative",clear:"both"})).parent(),e.data("floatThead-containerWrap",a),_=!0}return a};G?(J=ht(U,!0),J.prepend(at)):(J=ht(M),M.before(at))}else M.before(at);at.css({position:X?"absolute":"fixed",marginTop:0,top:X?0:"auto",zIndex:y.zIndex,willChange:"transform"}),at.addClass(y.floatContainerClass),g();var vt={"table-layout":"fixed"},bt={"table-layout":M.css("tableLayout")||"auto"},wt=M[0].style.width||"",gt=M.css("minWidth")||"",mt=!1;q();var yt,Tt=function(){(yt=z())()};Tt();var Ct=W(),xt=H();xt(Ct("init"),!0);var jt,St=s.debounce(function(){xt(Ct("windowScrollDone"),!1)},1),zt=function(){xt(Ct("windowScroll"),!1),Z&&St()},It=function(){xt(Ct("containerScroll"),!1)},Lt=function(){M.is(":hidden")||(g(),q(),Tt(),Ct=W(),(xt=H())(Ct("resize"),!0,!0))},Wt=s.debounce(function(){M.is(":hidden")||(q(),g(),Tt(),Ct=W(),xt(Ct("reflow"),!0))},1),Ht=function(){C()},qt=function(){T()},Rt=function(t){t.matches?Ht():qt()};if(window.matchMedia&&window.matchMedia("print").addListener?(jt=window.matchMedia("print"),jt.addListener(Rt)):(v.on("beforeprint",Ht),v.on("afterprint",qt)),G?X?U.on(c("scroll"),It):(U.on(c("scroll"),It),v.on(c("scroll"),zt)):(P.on(c("scroll"),It),v.on(c("scroll"),zt)),v.on(c("load"),Wt),e(c("resize"),Lt),M.on("reflow",Wt),y.support&&y.support.datatables&&i(M)&&M.on("filter",Wt).on("sort",Wt).on("page",Wt),y.support&&y.support.bootstrap&&v.on(c("shown.bs.tab"),Wt),y.support&&y.support.jqueryUI&&v.on(c("tabsactivate"),Wt),d){var Mt=null;s.isFunction(y.autoReflow)&&(Mt=y.autoReflow(M,U)),Mt||(Mt=U.length?U[0]:M[0]),b=new MutationObserver(function(t){for(var e=function(t){return t&&t[0]&&("THEAD"==t[0].nodeName||"TD"==t[0].nodeName||"TH"==t[0].nodeName)},o=0;o<t.length;o++)if(!e(t[o].addedNodes)&&!e(t[o].removedNodes)){Wt();break}}),b.observe(Mt,{childList:!0,subtree:!0})}M.data("floatThead-attached",{destroy:function(){var t=".fth-"+R;return C(),M.css(bt),ot.remove(),h&&$.remove(),lt.parent().length&&lt.replaceWith(k),x(!1),d&&(b.disconnect(),b=null),M.off("reflow reflowed"),U.off(t),P.off(t),_&&(U.length?U.unwrap():M.unwrap()),G?U.data("floatThead-containerWrap",!1):M.data("floatThead-containerWrap",!1),M.css("minWidth",gt),at.remove(),M.data("floatThead-attached",!1),v.off(t),jt&&jt.removeListener(Rt),Ht=qt=function(){},function(){return M.floatThead(y)}},reflow:function(){Wt()},setHeaderHeight:function(){p()},getFloatContainer:function(){return at},getRowGroups:function(){return F?at.find(">table>thead").add(M.children("tbody,tfoot")):M.children("thead,tbody,tfoot")}})}),this}}(function(){var t=window.jQuery;return"undefined"!=typeof module&&module.exports&&!t&&(t=require("jquery")),t}());

/*
 * jQuery Bootstrap Pagination v1.4.1
 * https://github.com/esimakin/twbs-pagination
 *
 * Copyright 2014-2016, Eugene Simakin <john-24@list.ru>
 * Released under Apache-2.0 license
 * http://apache.org/licenses/LICENSE-2.0.html
 */
!function(a,b,c,d){"use strict";var e=a.fn.twbsPagination,f=function(b,c){if(this.$element=a(b),this.options=a.extend({},a.fn.twbsPagination.defaults,c),this.options.startPage<1||this.options.startPage>this.options.totalPages)throw new Error("Start page option is incorrect");if(this.options.totalPages=parseInt(this.options.totalPages),isNaN(this.options.totalPages))throw new Error("Total pages option is not correct!");if(this.options.visiblePages=parseInt(this.options.visiblePages),isNaN(this.options.visiblePages))throw new Error("Visible pages option is not correct!");if(this.options.onPageClick instanceof Function&&this.$element.first().on("page",this.options.onPageClick),this.options.hideOnlyOnePage&&1==this.options.totalPages)return this.$element.trigger("page",1),this;this.options.totalPages<this.options.visiblePages&&(this.options.visiblePages=this.options.totalPages),this.options.href&&(this.options.startPage=this.getPageFromQueryString(),this.options.startPage||(this.options.startPage=1));var d="function"==typeof this.$element.prop?this.$element.prop("tagName"):this.$element.attr("tagName");return"UL"===d?this.$listContainer=this.$element:this.$listContainer=a("<ul></ul>"),this.$listContainer.addClass(this.options.paginationClass),"UL"!==d&&this.$element.append(this.$listContainer),this.options.initiateStartPageClick?this.show(this.options.startPage):(this.currentPage=this.options.startPage,this.render(this.getPages(this.options.startPage)),this.setupEvents()),this};f.prototype={constructor:f,destroy:function(){return this.$element.empty(),this.$element.removeData("twbs-pagination"),this.$element.off("page"),this},show:function(a){if(a<1||a>this.options.totalPages)throw new Error("Page is incorrect.");return this.currentPage=a,this.render(this.getPages(a)),this.setupEvents(),this.$element.trigger("page",a),this},enable:function(){this.show(this.currentPage)},disable:function(){var b=this;this.$listContainer.off("click").on("click","li",function(a){a.preventDefault()}),this.$listContainer.children().each(function(){var c=a(this);c.hasClass(b.options.activeClass)||a(this).addClass(b.options.disabledClass)})},buildListItems:function(a){var b=[];if(this.options.first&&b.push(this.buildItem("first",1)),this.options.prev){var c=a.currentPage>1?a.currentPage-1:this.options.loop?this.options.totalPages:1;b.push(this.buildItem("prev",c))}for(var d=0;d<a.numeric.length;d++)b.push(this.buildItem("page",a.numeric[d]));if(this.options.next){var e=a.currentPage<this.options.totalPages?a.currentPage+1:this.options.loop?1:this.options.totalPages;b.push(this.buildItem("next",e))}return this.options.last&&b.push(this.buildItem("last",this.options.totalPages)),b},buildItem:function(b,c){var d=a("<li></li>"),e=a("<a></a>"),f=this.options[b]?this.makeText(this.options[b],c):c;return d.addClass(this.options[b+"Class"]),d.data("page",c),d.data("page-type",b),d.append(e.attr("href",this.makeHref(c)).addClass(this.options.anchorClass).html(f)),d},getPages:function(a){var b=[],c=Math.floor(this.options.visiblePages/2),d=a-c+1-this.options.visiblePages%2,e=a+c;d<=0&&(d=1,e=this.options.visiblePages),e>this.options.totalPages&&(d=this.options.totalPages-this.options.visiblePages+1,e=this.options.totalPages);for(var f=d;f<=e;)b.push(f),f++;return{currentPage:a,numeric:b}},render:function(b){var c=this;this.$listContainer.children().remove();var d=this.buildListItems(b);a.each(d,function(a,b){c.$listContainer.append(b)}),this.$listContainer.children().each(function(){var d=a(this),e=d.data("page-type");switch(e){case"page":d.data("page")===b.currentPage&&d.addClass(c.options.activeClass);break;case"first":d.toggleClass(c.options.disabledClass,1===b.currentPage);break;case"last":d.toggleClass(c.options.disabledClass,b.currentPage===c.options.totalPages);break;case"prev":d.toggleClass(c.options.disabledClass,!c.options.loop&&1===b.currentPage);break;case"next":d.toggleClass(c.options.disabledClass,!c.options.loop&&b.currentPage===c.options.totalPages)}})},setupEvents:function(){var b=this;this.$listContainer.off("click").on("click","li",function(c){var d=a(this);return!d.hasClass(b.options.disabledClass)&&!d.hasClass(b.options.activeClass)&&(!b.options.href&&c.preventDefault(),void b.show(parseInt(d.data("page"))))})},makeHref:function(a){return this.options.href?this.generateQueryString(a):"#"},makeText:function(a,b){return a.replace(this.options.pageVariable,b).replace(this.options.totalPagesVariable,this.options.totalPages)},getPageFromQueryString:function(a){var b=this.getSearchString(a),c=new RegExp(this.options.pageVariable+"(=([^&#]*)|&|#|$)"),d=c.exec(b);return d&&d[2]?(d=decodeURIComponent(d[2]),d=parseInt(d),isNaN(d)?null:d):null},generateQueryString:function(a,b){var c=this.getSearchString(b),d=new RegExp(this.options.pageVariable+"=*[^&#]*");return c?"?"+c.replace(d,this.options.pageVariable+"="+a):""},getSearchString:function(a){var c=a||b.location.search;return""===c?null:(0===c.indexOf("?")&&(c=c.substr(1)),c)},getCurrentPage:function(){return this.currentPage}},a.fn.twbsPagination=function(b){var c,e=Array.prototype.slice.call(arguments,1),g=a(this),h=g.data("twbs-pagination"),i="object"==typeof b?b:{};return h||g.data("twbs-pagination",h=new f(this,i)),"string"==typeof b&&(c=h[b].apply(h,e)),c===d?g:c},a.fn.twbsPagination.defaults={totalPages:1,startPage:1,visiblePages:5,initiateStartPageClick:!0,hideOnlyOnePage:!1,href:!1,pageVariable:"{{page}}",totalPagesVariable:"{{total_pages}}",page:null,first:"First",prev:"Previous",next:"Next",last:"Last",loop:!1,onPageClick:null,paginationClass:"pagination",nextClass:"page-item next",prevClass:"page-item prev",lastClass:"page-item last",firstClass:"page-item first",pageClass:"page-item",activeClass:"active",disabledClass:"disabled",anchorClass:"page-link"},a.fn.twbsPagination.Constructor=f,a.fn.twbsPagination.noConflict=function(){return a.fn.twbsPagination=e,this},a.fn.twbsPagination.version="1.4.1"}(window.jQuery,window,document);
