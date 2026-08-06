package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.help.QuizDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.QuizResultsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetQuizQuestionsComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.PostQuizAnswersComposer;
   import com.sulake.habbo.communication.messages.parser.help.QuizDataMessageParser;
   import com.sulake.habbo.communication.messages.parser.help.QuizResultsMessageParser;
   import com.sulake.habbo.window.utils.IModalDialog;
   
   public class HabboWayQuizController implements IComponentInterfaceQueue
   {
      private static const HABBO_WAY_QUIZ_CODE:String = "HabboWay1";
      
      private static const SAFETY_QUIZ_CODE:String = "SafetyQuiz1";
      
      private static const PAGE_QUESTION:int = 1;
      
      private static const PAGE_SUCCESS:int = 2;
      
      private static const PAGE_FAILURE:int = 3;
      
      private static const PAGE_ANALYSIS:int = 4;
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var UnknownVarFromHabboWayQuizController_IModalDialog_1:IModalDialog;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabboWayQuizController_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromHabboWayQuizController_ISelectorListWindow_1:ISelectorListWindow;
      
      private var UnknownVarFromHabboWayQuizController_ISelectableWindow_1:ISelectableWindow;
      
      private var UnknownVarFromHabboWayQuizController_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromHabboWayQuizController_IWindowModel_1:IWindowModel;
      
      private var _quizCode:String;
      
      private var UnknownVarFromHabboWayQuizController_Array_1:Array;
      
      private var UnknownVarFromHabboWayQuizController_Array_2:Array;
      
      private var _answerOrders:Array;
      
      private var _questionIdsForWrongAnswers:Array;
      
      private var UnknownVarFromHabboWayQuizController_Int_1:int;
      
      public function HabboWayQuizController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new QuizDataMessageEvent(onQuizData));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new QuizResultsMessageEvent(onQuizResults));
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromHabboWayQuizController_IWindowController_1_1 = null;
            UnknownVarFromHabboWayQuizController_ISelectorListWindow_1 = null;
            if(UnknownVarFromHabboWayQuizController_ISelectableWindow_1 != null)
            {
               UnknownVarFromHabboWayQuizController_ISelectableWindow_1.dispose();
               UnknownVarFromHabboWayQuizController_ISelectableWindow_1 = null;
            }
            UnknownVarFromHabboWayQuizController_IItemListWindow_1 = null;
            if(UnknownVarFromHabboWayQuizController_IWindowModel_1 != null)
            {
               UnknownVarFromHabboWayQuizController_IWindowModel_1.dispose();
               UnknownVarFromHabboWayQuizController_IWindowModel_1 = null;
            }
            closeWindow();
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showHabboWayQuiz() : void
      {
         _habboHelp.sendMessage(new GetQuizQuestionsComposer("HabboWay1"));
      }
      
      public function showSafetyQuiz() : void
      {
         _habboHelp.sendMessage(new GetQuizQuestionsComposer("SafetyQuiz1"));
      }
      
      private function onQuizData(param1:QuizDataMessageEvent) : void
      {
         var _loc2_:QuizDataMessageParser = param1.getParser();
         _habboHelp.closeHabboWay();
         _habboHelp.closeSafetyBooklet();
         showWindow(_loc2_.quizCode,_loc2_.questionIds);
      }
      
      private function onQuizResults(param1:QuizResultsMessageEvent) : void
      {
         var _loc2_:QuizResultsMessageParser = param1.getParser();
         _questionIdsForWrongAnswers = _loc2_.questionIdsForWrongAnswers;
         if(_questionIdsForWrongAnswers.length == 0)
         {
            showPage(2);
         }
         else
         {
            showPage(3);
         }
      }
      
      private function showWindow(param1:String, param2:Array) : void
      {
         closeWindow();
         UnknownVarFromHabboWayQuizController_IModalDialog_1 = _habboHelp.getModalXmlWindow("habbo_way_quiz");
         _window = IWindowController_1(UnknownVarFromHabboWayQuizController_IModalDialog_1.rootWindow);
         _window.procedure = onWindowEvent;
         UnknownVarFromHabboWayQuizController_IWindowController_1_1 = IWindowController_1(_window.findChildByName("question_pane"));
         UnknownVarFromHabboWayQuizController_ISelectorListWindow_1 = ISelectorListWindow(UnknownVarFromHabboWayQuizController_IWindowController_1_1.findChildByName("answer_list"));
         UnknownVarFromHabboWayQuizController_ISelectableWindow_1 = UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.getSelectableAt(0);
         UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.removeSelectable(UnknownVarFromHabboWayQuizController_ISelectableWindow_1);
         UnknownVarFromHabboWayQuizController_IItemListWindow_1 = IItemListWindow(_window.findChildByName("analysis_pane"));
         UnknownVarFromHabboWayQuizController_IWindowModel_1 = UnknownVarFromHabboWayQuizController_IItemListWindow_1.getListItemAt(0);
         UnknownVarFromHabboWayQuizController_IItemListWindow_1.removeListItems();
         UnknownVarFromHabboWayQuizController_IItemListWindow_1.spacing = 4;
         _quizCode = param1;
         UnknownVarFromHabboWayQuizController_Array_1 = param2;
         UnknownVarFromHabboWayQuizController_Array_2 = new Array(questionCount);
         _answerOrders = new Array(questionCount);
         setCurrentQuestion(0);
         var _loc3_:IWindowController_1 = IWindowController_1(IItemListWindow(UnknownVarFromHabboWayQuizController_IWindowModel_1).getListItemByName("explanation_container"));
         switch(_quizCode)
         {
            case "HabboWay1":
               IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}habboway/quiz_question.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "help_habboway_dove_on";
               IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}habboway/quiz_success.png";
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("explanation_illustration")).assetUri = "help_habboway_dove_quizz";
               break;
            case "SafetyQuiz1":
               IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}safetyquiz/question_illustration.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("failure_illustration")).assetUri = "${image.library.url}safetyquiz/result_failure.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}safetyquiz/result_success.png";
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("explanation_illustration")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
         }
         showPage(1);
      }
      
      private function closeWindow() : void
      {
         _window = null;
         if(UnknownVarFromHabboWayQuizController_IModalDialog_1 != null)
         {
            UnknownVarFromHabboWayQuizController_IModalDialog_1.dispose();
            UnknownVarFromHabboWayQuizController_IModalDialog_1 = null;
         }
      }
      
      private function showPage(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:IItemListWindow = null;
         var _loc6_:String = null;
         var _loc9_:String = null;
         _window.findChildByName("question_pane").visible = param1 == 1;
         _window.findChildByName("success_pane").visible = param1 == 2;
         _window.findChildByName("failure_pane").visible = param1 == 3;
         UnknownVarFromHabboWayQuizController_IItemListWindow_1.visible = param1 == 4;
         _window.findChildByName("prev_next_buttons").visible = param1 == 1;
         _window.findChildByName("failure_buttons").visible = param1 == 3;
         _window.findChildByName("exit_button_container").visible = param1 == 2 || param1 == 4;
         var _loc3_:IWindowModel = _window.findChildByName("top_indicator");
         var _loc7_:IWindowModel = _window.findChildByName("indicator_image");
         switch(param1 - 1)
         {
            case 0:
               _window.caption = getFullLocalizationKey("question.title");
               _loc7_.visible = true;
               _loc3_.visible = true;
               _loc3_.caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"),"","current_page",1,"page_count",questionCount.toString());
               _loc3_.caption = getFullLocalizationKey("question.page");
               break;
            case 1:
               _window.caption = getFullLocalizationKey("success.title");
               _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
               _window.findChildByName("success_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("success.results"),"","question_count",questionCount.toString());
               _loc7_.visible = false;
               _loc3_.visible = false;
               _loc3_.caption = "";
               break;
            case 2:
               _loc5_ = UnknownVarFromHabboWayQuizController_Array_1.length - _questionIdsForWrongAnswers.length;
               _window.caption = getFullLocalizationKey("failure.title");
               _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
               _window.findChildByName("failure_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("failure.results"),"","correct_count",_loc5_.toString(),"total_count",questionCount.toString());
               _loc7_.visible = false;
               _loc3_.visible = false;
               _loc3_.caption = "";
               break;
            case 3:
               _window.caption = getFullLocalizationKey("analysis.title");
               _loc7_.visible = true;
               _loc3_.visible = true;
               _loc3_.caption = getFullLocalizationKey("analysis.top");
               for each(var _loc4_ in _questionIdsForWrongAnswers)
               {
                  _loc2_ = int(UnknownVarFromHabboWayQuizController_Array_2[UnknownVarFromHabboWayQuizController_Array_1.indexOf(_loc4_)]);
                  _loc8_ = IItemListWindow(UnknownVarFromHabboWayQuizController_IWindowModel_1.clone());
                  _loc6_ = "${quiz." + _quizCode + ".";
                  _loc9_ = "." + _loc4_ + "." + _loc2_ + "}";
                  _loc8_.getListItemByName("question").caption = _loc6_ + "question." + _loc4_ + "}";
                  IWindowController_1(_loc8_.getListItemByName("answer_container")).findChildByName("answer").caption = _loc6_ + "answer" + _loc9_;
                  IWindowController_1(_loc8_.getListItemByName("explanation_container")).findChildByName("explanation").caption = _loc6_ + "explanation" + _loc9_;
                  UnknownVarFromHabboWayQuizController_IItemListWindow_1.addListItem(_loc8_);
               }
               IItemListWindow(UnknownVarFromHabboWayQuizController_IItemListWindow_1.getListItemAt(UnknownVarFromHabboWayQuizController_IItemListWindow_1.numListItems - 1)).getListItemByName("separator").dispose();
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(_disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2 is ISelectableWindow)
         {
            UnknownVarFromHabboWayQuizController_Array_2[UnknownVarFromHabboWayQuizController_Int_1] = int(param2.name);
            _window.findChildByName("next_dimmer").visible = false;
         }
         else
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "exit_button":
                  closeWindow();
                  break;
               case "prev_button":
                  setCurrentQuestion(UnknownVarFromHabboWayQuizController_Int_1 - 1);
                  break;
               case "next_button":
                  setCurrentQuestion(UnknownVarFromHabboWayQuizController_Int_1 + 1);
                  break;
               case "review_button":
                  showPage(4);
            }
         }
      }
      
      private function setCurrentQuestion(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc10_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc6_:ISelectableWindow = null;
         var _loc7_:int = 0;
         var _loc5_:ISelectableWindow = null;
         var _loc9_:ISelectableWindow = null;
         if(param1 >= questionCount)
         {
            _habboHelp.sendMessage(new PostQuizAnswersComposer(_quizCode,UnknownVarFromHabboWayQuizController_Array_2));
         }
         else if(param1 >= 0)
         {
            UnknownVarFromHabboWayQuizController_Int_1 = param1;
            _window.findChildByName("prev_dimmer").visible = param1 <= 0;
            _window.findChildByName("next_dimmer").visible = UnknownVarFromHabboWayQuizController_Array_2[UnknownVarFromHabboWayQuizController_Int_1] == null;
            _window.findChildByName("top_indicator").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"),"","current_page",String(param1 + 1),"page_count",questionCount.toString());
            while(UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.numSelectables > 0)
            {
               UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.removeSelectable(UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.getSelectableAt(0)).dispose();
            }
            _loc3_ = int(UnknownVarFromHabboWayQuizController_Array_1[UnknownVarFromHabboWayQuizController_Int_1]);
            _loc10_ = [];
            UnknownVarFromHabboWayQuizController_IWindowController_1_1.findChildByName("question").caption = "${quiz." + _quizCode + ".question." + _loc3_ + "}";
            _loc2_ = 0;
            while(true)
            {
               _loc4_ = _habboHelp.localization.getLocalization("quiz." + _quizCode + ".answer." + _loc3_ + "." + _loc2_,"");
               if(_loc4_.length <= 0)
               {
                  break;
               }
               _loc6_ = ISelectableWindow(UnknownVarFromHabboWayQuizController_ISelectableWindow_1.clone());
               _loc6_.caption = _loc4_;
               _loc6_.name = _loc2_.toString();
               _loc10_.push(_loc6_);
               _loc2_++;
            }
            if(_answerOrders[UnknownVarFromHabboWayQuizController_Int_1] == null)
            {
               _answerOrders[UnknownVarFromHabboWayQuizController_Int_1] = [];
               _loc7_ = 0;
               while(_loc7_ < _loc2_)
               {
                  _loc5_ = _loc10_.splice(int(Math.random() * _loc10_.length),1)[0];
                  UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.addSelectable(_loc5_);
                  _answerOrders[UnknownVarFromHabboWayQuizController_Int_1].push(int(_loc5_.name));
                  _loc7_++;
               }
            }
            else
            {
               for each(var _loc8_ in _answerOrders[UnknownVarFromHabboWayQuizController_Int_1])
               {
                  UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.addSelectable(_loc10_[_loc8_]);
               }
            }
            _loc9_ = UnknownVarFromHabboWayQuizController_ISelectorListWindow_1.getSelectableByName(String(UnknownVarFromHabboWayQuizController_Array_2[UnknownVarFromHabboWayQuizController_Int_1]));
            if(_loc9_ != null)
            {
               _loc9_.select();
            }
         }
      }
      
      private function get questionCount() : int
      {
         return UnknownVarFromHabboWayQuizController_Array_1 != null ? UnknownVarFromHabboWayQuizController_Array_1.length : 0;
      }
      
      private function getFullLocalizationKey(param1:String) : String
      {
         return "${" + getRawLocalizationKey(param1) + "}";
      }
      
      private function getRawLocalizationKey(param1:String) : String
      {
         var _loc2_:String = _quizCode;
         if("HabboWay1" !== _loc2_)
         {
            return "quiz." + _quizCode + "." + param1;
         }
         return "habbo.way.quiz." + param1;
      }
   }
}

