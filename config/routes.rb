Rails.application.routes.draw do

    root to: 'topics#index'

    get 'topics/new'
    get 'topics/completed' => 'topics#finished_topics', as: 'topics_finished'
    get 'topics/:id' => 'topics#show', as: 'topic'
    post 'topics' => 'topics#create'
    post 'topics/:id/approve' => 'topics#update_approval', as: 'topics_approve'
    post 'topics/:id/finish' => 'topics#finish',  as: 'topics_finish'
    
    
end
