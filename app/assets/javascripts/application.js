// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//
//= require jquery.raty.js

// インクリメンタル検索候補表示位置調整
$(document).on('turbolinks:load', function () {
  $('.navbar-toggler').click(function() {
    if ($('.navbar-collapse').hasClass('show')) {
      $('#wrap').css('padding-top', '92px')
    } else {
      // ハンバーガーメニュー開いている時→アイコン増えたらheight調整
      $('#wrap').css('padding-top', '420px')
    }
  })
});

// インクリメンタル検索
$(document).on('turbolinks:load', function () {
  $('.js-text_field').on('keyup', function () {
    search();
    if ($('.js-text_field').val() === '') {
      $('.search-result').fadeOut(500)
    } else {
      $('.search-result').show()
    }
  });
  $("#model").change(function() {
    search();
  });
});
function search() {
  var content = $('.js-text_field').val();
  var target = $('#model option:selected').val();
  $.ajax({
    type: 'GET', // リクエストのタイプ
    url: '/search', // リクエストを送信するURL
    data:  { content: content, model: target }, // サーバーに送信するデータ
    dataType: 'json' // サーバーから返却される型
  })
  .done(function (data) {
    // 楽曲指定で何か入力した結果が5件の時、console.log(data)の結果は以下になる
    // >>{mode: 'musical_pieces', data: Array(5)}
    // >>data: (5) [{…}, {…}, {…}, {…}, {…}]
    // >>mode: "musical_pieces"
    var search_result_data = [] // 空の配列を用意
      // modeで条件分岐後、配列にデータ(aタグ)を追加
    if (data.mode === "musical_pieces") {
      data.data.forEach(result => {// 検索結果をループ
        // >>push() メソッドは、配列の末尾に1つ以上の要素を追加する
        // >>テンプレートリテラルは、ダブルクオートやシングルクオートの代わりにバックティック文字 (` `) (グレイヴ・アクセント) で囲みます。
        // >>テンプレートリテラルにはプレースホルダーを含めることができます。
        // >>プレースホルダーはドル記号と波括弧 (${expression}) で示されます。プレースホルダー内の式とバックティック文字 (` `) の間にあるテキストが関数に渡されます。
        search_result_data.push(`<a href="/musical_pieces/${result.id}">${result.musical_piece_name}</a>`)
      })
    } else {// modeがcomposersの場合
      data.data.forEach(result => {// 検索結果をループ
        search_result_data.push(`<a href="/composers/${result.id}">${result.name_kana}</a>`)
      })
    }
    // 結果の配列search_result_dataをbrで文字列に結合する
    $(".search-result").html(search_result_data.join("<br>"));
  })
};