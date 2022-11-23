#（A）（８）最初の行（座席数と入店するグループの総数）の入力を受け付けます 取得した値を分割して配列にする(空白で区切る)
seats_and_groups = gets.split(/\s/)
#（B）（１０）座席を配列で作成します 空席＝[1〜椅子の数]の配列（後で変更される）
empty_seat = [*1..(seats_and_groups[0].to_i)]
#（C）（１３）座席の数を変数に入れておきます 空席数（元々の椅子の数）
seats_count = empty_seat.count
#（D）（１１）何組のグループが入店するのか、その数を変数に入れておきます グループ数(取得した数の２番目)
binding.irb
number_of_visitors = seats_and_groups[1].to_i
#（E）（１５）入店するグループの数だけループさせます [1〜グループ数]の配列分繰り返す(何行かが決まる)
[*1..number_of_visitors].each do
#（F）（４）二行目以降の行（グループの人数と着席開始座席番号）の入力を受け付けます グループの人数と、何番目の椅子から座るかの取得
  used_seats = gets.split(/\s/)
#（G）（６）来店したグループの人数を変数に代入します グループの人数
  users = used_seats[0].to_i
#（H）（１２）来店したグループの着席開始座席番号を変数に代入します 何番目の椅子から座るか（最初に座る座席番号の数字）
  seating_number = used_seats[1].to_i
#（I）（９）来店したグループの最後の人間が着席した座席の番号を変数に代入します 何番目の椅子まで座るか（最後に座る座席番号の数字）
  fill_last_number = ((seating_number + users) - 1)
#（J）（７）来店したグループが座席につけるかどうかを確認するための配列を、if文で条件分けしながら定義します。
# もし、最後に座る座席番号の数字が、空席数の数字より大きかったら（１周をオーバーする時）
  if fill_last_number > seats_count
    #（K）（３）もしも最後の人間が着席した座席の番号が、最初に定義された座席の数を超えていたら、最初の座席の数に戻して再計算します（円卓だから）
    # ２周目に入って、最後に座る座席番号の数字が決まる。
    # （下記のコードは理解が難しいので、下記にヒントを載せます）
    # 「今回のグループが最後に着席する座席の番号」 = 「今回のグループが最後に着席する座席の番号」-「そもそもの座席の総数」となる（円卓だから）。
    # 例えば、fill_last_number == 13で、seats_countが12だったら、1 = 13 - 12となり、座席番号が１の座席に最後の人間が座る。
    fill_last_number = fill_last_number - seats_count
    # （下記のコードは理解が難しいので、下記にヒントを載せます）
    # next_seat_candidateは、「その座席に既に人が座っていないか？」を判断するための配列
    # ([*1..seats_count] - empty_seat)は、（「全ての座席」-「まだ人が座っていない座席」）の意味。つまり、「既に人が座っている座席」の数字が、([*1..seats_count] - empty_seat)
    # [*seating_number..seats_count]は、[*「今回のグループが最初に着席する座席の番号」..「最後の座席の番号」]の意味
    # [*1..fill_last_number]は、[*「１（最初の座席）」..「今回のグループが最後に着席する座席の番号」]の意味
    # なので、next_seat_candidate = ([*1..seats_count] - empty_seat) + [*seating_number..seats_count] + [*1..fill_last_number]は、
    # next_seat_candidate = 「既に人が座っている座席」+ [*「今回のグループが最初に着席する座席の番号」..「最後の座席の番号」] + [*「１（最初の座席）」..「今回のグループが最後に着席する座席の番号」]となる。
    # つまり、 next_seat_candidateの配列の中に、同じ数字が含まれていれば、「既に埋まっている座席に新たなグループの人間が座ろうとしている」ということになる
    #(最後の座席番号と、２周目の最後の座席番号も)
    next_seat_candidate = ([*1..seats_count] - empty_seat) + [*seating_number..seats_count] + [*1..fill_last_number]
    else #（１周以内で収まる時）
    # （L）（２）最後の人間が着席した座席の番号が、最初に定義された座席の数を超えていなかったら、そのまま計算します 単純に、最初の座席番号から最後の座席番号
    # （下記のコードは理解が難しいので、下記にヒントを載せます）
    # next_seat_candidate = 「既に人が座っている座席」+ [*「今回のグループが最初に着席する座席の番号」..「今回のグループが最後に着席する座席の番号」]となる
    # つまり、 next_seat_candidateの配列の中に、同じ数字が含まれていれば、「既に埋まっている座席に新たなグループの人間が座ろうとしている」ということになる
    next_seat_candidate = ([*1..seats_count] - empty_seat) + [*seating_number..fill_last_number]
  end
  p ([*1..seats_count] - empty_seat)
  p [*seating_number..fill_last_number]
  p next_seat_candidate
  # （M）（５）来店したグループの座りたい座席がすでに埋まっていないかをif文で確認します（埋まっていなければif内の処理をします）
  # もしnext_seat_candidateの中に同じ数字が含まれてなければ（要素数が同じであれば）(席が埋まってなければ)
  if next_seat_candidate.count == next_seat_candidate.uniq.count
    #（N）（１４）最後の人間が着席した座席の番号が、最初に定義された座席の数を超えていた場合と、そうでない場合とで座席の埋め方をif文で分岐させます
    # かつ、もし最後に座る座席番号の数字が椅子の数より多かったら（１周をオーバーする時）
    if ((seating_number + users) - 1) > seats_count
      #（O）（１７）埋まっていない、かつ、末尾の番号が最初に定義された座席の数を超えていれば、最初の座席の番号〜末尾の番号と、着席開始座席番号〜最後の座席の番号、の二回に分けて座席を埋めていきます
      empty_seat = empty_seat - [*1..fill_last_number] #空席は、全体から(1〜２周目の最後の座席番号)を引いたものになる
      empty_seat = empty_seat - [*seating_number..seats_count] #空席は、最初の座席番号から椅子の数の番号を引いたものになる
    else #（１周以内で収まる時）
      # （P）（１）埋まっていない、かつ、末尾の番号が座席の数を超えていなければ、そのまま来店した人数分の座席を埋めていきます
      # 単純に、最初の座席番号から最後の座席番号を引く
      empty_seat = empty_seat - [*seating_number..fill_last_number]
    end
  end #同じ数字が含まれていた時は、座れないから、帰ってもらう（空席数に変動なし）
end
# （Q）（１６）最終的に座席に座っている人数を出力します 元々の椅子の数から、空席数を引いた数（occupied seat)を表示！
puts seats_count - empty_seat.count