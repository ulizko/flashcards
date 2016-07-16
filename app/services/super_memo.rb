class SuperMemo
  # Q_SUMMAND[q] = (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
  Q_SUMMAND = [-0.8, -0.54, -0.32, -0.14, 0, 0.1].freeze

  def initialize(card, check_translate, time)
    @card = card
    @cheked_translate = check_translate.strip.downcase
    @time = time
  end

  def get_result
    { quality: grade,
      efactor: new_efactor,
      interval: next_interval,
      repeat: next_repeat,
      messages: messages }
  end

  def new_efactor
    [@card.efactor + Q_SUMMAND[grade], 1.3].max
  end

  def grade
    if check_card? && typo_relative.zero? && @time < 10
      5
    elsif check_card? && typo_relative.zero? && @time < 15
      4
    elsif @time < 30 && (check_card? || typo_relative <= 0.33)
      3
    elsif typo_relative == 0.5
      2
    elsif typo_relative > 0.5
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
    grade < 3 ? 0 : (@card.repeat + 1)
  end

  def check_card?
    @card.original_text.downcase == @cheked_translate
  end

  def typo_relative
    DamerauLevenshtein.distance(@card.original_text, @cheked_translate) / @card.original_text.length.to_f
  end

  def messages
    result = {}
    result[:status] = check_card? ? 'success' : 'danger'
    result[:message] = if check_card? && @time > 30
                         I18n.t('cards.check.too_long')
                       elsif check_card?
                         I18n.t('cards.check.right')
                       elsif typo_relative <= 0.33
                         I18n.t('cards.check.oops', original_text: @card.original_text,
                                    check_translate: @cheked_translate)
                       else
                         I18n.t('cards.check.wrong')
                       end
    result
  end
end
