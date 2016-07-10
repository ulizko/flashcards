class CardChecker
  Q_SUMMAND = [-0.8, -0.54, -0.32, -0.14, 0, 0.1].freeze

  def initialize(card, check_translate, time)
    @card = card
    @cheked_translate = check_translate
    @time = time
  end

  def get_result
    { quality: grade, 
      efactor: new_efactor,
      interval: next_interval,
      repeat: next_repeat }
  end

  private

  def check_card?
    original_text == checking
  end

  def levenstein
    DamerauLevenshtein.distance(original_text, checking)
  end

  def original_text
    @card.original_text.downcase
  end

  def checking
    @cheked_translate.strip.downcase
  end

  def new_efactor
    [@card.efactor + Q_SUMMAND[grade], 1.3].max
  end

  def grade
    if check_card? && levenstein.zero? && @time < 10
      5
    elsif check_card? && levenstein.zero? && @time < 15
      4
    elsif check_card? && (levenstein < 2 || @time < 20)
      3
    elsif levenstein == 3
      2
    elsif levenstein == 4
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
    0 if grade < 3
    @card.repeat + 1 
  end
end