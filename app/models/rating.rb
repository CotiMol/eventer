class Rating < ActiveRecord::Base
  belongs_to :user
  attr_accessible 	:global_nps, :global_nps_count,
  					:global_event_rating, :global_event_rating_count, 
  					:global_trainer_rating, :global_trainer_rating_count

  def self.calculate( author = User.first )
  	
  	rating = Rating.first
  	if rating.nil?
  		rating = Rating.new()
  	end

  	rating.user = author

  	# calculate global numbers
  	global_promoter_count = Participant.attended.surveyed.promoter.length.to_f
    global_passive_count = Participant.attended.surveyed.passive.length.to_f
    global_detractor_count = Participant.attended.surveyed.detractor.length.to_f
    rating.global_nps_count = (global_promoter_count+global_passive_count+global_detractor_count)

    if rating.global_nps_count > 0
      global_promoter_percent = global_promoter_count / rating.global_nps_count
      global_detractor_percent = global_detractor_count / rating.global_nps_count

      rating.global_nps = ((global_promoter_percent - global_detractor_percent).round(2)*100).to_i

    else
      rating.global_nps = nil
    end

  	rating.global_event_rating = Participant.attended.surveyed.average("event_rating").to_f.round(2)
  	rating.global_event_rating_count = Participant.attended.surveyed.count

  	rating.global_trainer_rating = Participant.attended.surveyed.average("trainer_rating").to_f.round(2)
  	rating.global_trainer_rating_count = Participant.attended.surveyed.count

  	# calculate events ratings
  	Event.select{ |e| e.participants.surveyed.count > 0 }.each do |e|
  		#rating
  		cualified_participants = e.participants.attended.surveyed

	    if cualified_participants.length > 0
	      e.average_rating = cualified_participants.collect{ |p| p.event_rating}.sum.to_f/cualified_participants.length
	    end

  		#nps
  		promoter_count = cualified_participants.promoter.length.to_f
		passive_count = cualified_participants.passive.length.to_f
		detractor_count = cualified_participants.detractor.length.to_f
		attended_count = (promoter_count+passive_count+detractor_count)
		
		if (promoter_count+detractor_count) > 0
		   promoter_percent = promoter_count / attended_count
		   detractor_percent = detractor_count / attended_count
		
		   e.net_promoter_score = ((promoter_percent - detractor_percent).round(2)*100).to_i
	
		else
		   e.net_promoter_score = nil
		end 

  		e.save! unless !e.valid?
  	end

  	# calculate event_type ratings
  	EventType.select{ |et| et.participants.surveyed.count > 0 }.each do |et|
  		#rating
  		cualified_participants = et.participants.attended.surveyed

	    if cualified_participants.count > 0
	      et.average_rating = cualified_participants.collect{ |p| p.event_rating}.sum.to_f/cualified_participants.length
	      et.surveyed_count = cualified_participants.count
	    end

  		#nps
  		promoter_count = cualified_participants.promoter.length.to_f
		passive_count = cualified_participants.passive.length.to_f
		detractor_count = cualified_participants.detractor.length.to_f
		attended_count = (promoter_count+passive_count+detractor_count)
		
		if (promoter_count+detractor_count) > 0
		   promoter_percent = promoter_count / attended_count
		   detractor_percent = detractor_count / attended_count
		
		   et.promoter_count = promoter_count
		   et.net_promoter_score = ((promoter_percent - detractor_percent).round(2)*100).to_i
	
		else
		   et.net_promoter_score = nil
		end 

  		et.save! unless !et.valid?
  	end

  	# calculate trainer ratings
  	Trainer.select{ |tr| tr.participants.surveyed.count > 0 }.each do |tr|
  		#rating
  		cualified_participants = tr.participants.attended.surveyed

	    if cualified_participants.count > 0
	      tr.average_rating = cualified_participants.collect{ |p| p.event_rating}.sum.to_f/cualified_participants.length
	      tr.surveyed_count = cualified_participants.count
	    end

  		#nps
  		promoter_count = cualified_participants.promoter.length.to_f
		passive_count = cualified_participants.passive.length.to_f
		detractor_count = cualified_participants.detractor.length.to_f
		attended_count = (promoter_count+passive_count+detractor_count)
		
		if (promoter_count+detractor_count) > 0
		   promoter_percent = promoter_count / attended_count
		   detractor_percent = detractor_count / attended_count
		
		   tr.promoter_count = promoter_count
		   tr.net_promoter_score = ((promoter_percent - detractor_percent).round(2)*100).to_i
	
		else
		   tr.net_promoter_score = nil
		end 

  		tr.save! unless !tr.valid?
  	end

  	rating.save!

  end

end
