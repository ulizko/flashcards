module SuperMemo
  Q_SUMMAND = [-0.8, -0.54, -0.32, -0.14, 0, 0.1].freeze

  def grade(check_card, levenstein, time)
    if check_card && levenstein.zero? && time < 10
      5
    elsif check_card && levenstein.zero? && time < 15
      4
    elsif check_card && (levenstein < 2 || time < 20)
      3
    elsif levenstein == 3
      2
    elsif levenstein == 4
      1
    else
      0
    end
  end

  def e_f(current_efactor)
    current_efactor + Q_SUMMAND[grade]
  end
end