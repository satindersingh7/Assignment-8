
        $(document).ready(function () {
            $(".autotxtsearch").autocomplete({
                 source: function (request, response) {
                   if (request.term.length >= 3) {
                      $('.ui-autocomplete').addClass('show');
                      $.ajax({
                          url: 'default.aspx/GetProducts',
                          data: "{ 'prefix': '" + request.term + "','selval': '" + $('#ddl_Category').val() + "'}",
                          dataType: "json",
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          dataFilter: function (request) { return request },
                          success: function (data) {
                              $('.test ul').empty();
                              response($.map(data.d, function (item) {

                                  return {

                                      //value: item.DisplayName,
                                      //avatar: item.PicLocation,
                                      //rep: item.Reputation,
                                      //selectedId: item.UserUniqueid,
                                      image: item.ProductImage,
                                      title: item.ProductName,
                                      id: item.ProductId,
                                      brand: item.brand,

                                  }

                              }))

                          },

                          error: function (response) {
                             // alert(response.responseText);
                          },
                          failure: function (response) {
                             // alert(response.responseText);
                          }

                      });
                  }
                },
                select: function (e, i) {
                    $("[id$=hfProductId]").val(i.item.val),
                    $(".autotxtsearch").removeClass("placeholdertxt"),
                 window.location.href = e.item.href
                },
                open: function (t, e) {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top")
                }, close: function () { $(this).removeClass("ui-corner-top").addClass("ui-corner-all") },
                search: function () { $(this).addClass('autocomplete-loading'); },
                open: function () { $(this).removeClass('autocomplete-loading'); },
                minLength: 1
          }).data("ui-autocomplete")._renderItem = function (ul, item) {
              return "Not found" != item.title ? $("<li></li>").data("item.autocomplete", item).append("<a title='" + item.title + "' href='product-detail.aspx?id=" + item.id + "'><div><div class='search-thumb'><img id='flag' align='left' alt='" + item.title + "' src='" + item.image + "'/></div><span class='search-text'> <b>" + (item.title.length > 40 ? item.title.substr(0, 40) + "..." : item.title) + "</b><br/> in <b>" + item.brand + "</b></span> <br clear='all'/></div> </a><hr style='margin:0px;padding:0px;'/>").appendTo(ul).appendTo($('.test ul')) : $("<li>").data("item.autocomplete", item).append("<font color='red'>No Records Found...</font>").appendTo(ul).appendTo($('.test ul'));
              $('#ui-id-1').remove();
          }
          $('#ui-id-1').remove();
        });
