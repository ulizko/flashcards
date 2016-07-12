class SuperMemo
  Q_SUMMAND = [-0.8, -0.54, -0.32, -0.14, 0, 0.1].freeze

  def initialize(card, cheked, time, typo)
    @card = card
    @cheked_translate = cheked
    @time = time
    @typo = typo
  end

  def get_result
    { quality: grade,
      efactor: new_efactor,
      interval: next_interval,
      repeat: next_repeat }
  end

  private

  def new_efactor
    [@card.efactor + Q_SUMMAND[grade], 1.3].max
  end

  def grade
    if @cheked_translate && @typo.zero? && @time < 10
      5
    elsif @cheked_translate && @typo.zero? && @time < 15
      4
    elsif @cheked_translate && (@typo <= 2 || @time < 30)
      3
    elsif @typo == 3
      2
    elsif @typo > 3
      1
    else
      0
    end
  end

  def next_interval
    return 1 if grade < 3
    if @card.repeat == 0
      1
    elsif @card.repeat == 1
      6
    else
      (@card.interval * new_efactor).round
    end
  end

  def next_repeat
    return 0 if grade < 3
    @card.repeat + 1
  end
end
