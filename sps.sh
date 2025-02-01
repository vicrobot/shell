#!/bin/bash

# stone paper scissor

computer_chooses_this(){

    case $computer_choice_num in
        0) echo "Computer chose Stone";;
        1) echo "Computer chose Paper";;
        2) echo "Computer chose Scissor";;
        *) echo "wrong choice, unexpected";exit 1;;
    esac

}


wanna_play_again(){

    local wanna_play=1
    echo "wanna play again? y/n ?"
        read resp
        case $resp in
            y)
                echo "Let's play again!";;

            n) 
                echo "Bye"
                wanna_play=0;;
            *)
                echo "Wrong option, let's play again as you can quit anytime anyways";;
         esac
    return $wanna_play
}



while [[ 1 ]]; do
    
    # liver: game starts, asks choice # shravan
    echo 'Choose stone, paper, or scissor'
    read human_choice
    human_choice_num=0
    # liver: choice-number mapping
    case $human_choice in
        stone)
            human_choice_num=0;;
        paper)
            human_choice_num=1;;
        scissor)
            human_choice_num=2;;
        *)
            echo "You chose $human_choice"
            echo "wrong choice, please reselect"
            continue;;
    esac
    
    # liver: computer also has a choice, already in number. # vachan/dhyaan
    secs=$( date "+%s"  )
    computer_choice_num=`expr $secs % 3`
    
    # liver: choice analysis #manan
    if [[ $human_choice_num == $computer_choice_num ]]; then
        echo "tie, please try again"
        computer_chooses_this $computer_choice_num
        # manager: rematch or not
        wanna_play_again
        wanna_play=$?
        if [[ $wanna_play != 1 ]]; then break; fi
        
        
    elif [[ `expr $(( $computer_choice_num + 1 )) % 3` == $human_choice_num ]] ;then
        # c 0 stone h 1 paper
        # c 1 paper h 2 scissor
        # c 2 scissor h (2+1)%3=0 stone
        echo "you defeated computer"
        computer_chooses_this $computer_choice_num
        # manager: rematch or not
        wanna_play_again
        wanna_play=$?
        if [[ $wanna_play != 1 ]]; then break; fi
        
    else
        echo "you lost"
        computer_chooses_this $computer_choice_num
        # manager: rematch or not
        wanna_play_again
        wanna_play=$?
        if [[ $wanna_play != 1 ]]; then break; fi
    fi
done






    
