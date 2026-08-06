package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.parser.poll.PollChoice;
   import com.sulake.habbo.communication.messages.parser.poll.PollQuestion;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   
   public class PollContentDialog implements IPollOfferDialog
   {
      private var UnknownVarFromPollContentDialog_Int_1:int = -1;
      
      private var _disposed:Boolean = false;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromPollContentDialog_PollWidget_1:PollWidget;
      
      private var UnknownVarFromPollContentDialog_IFrameController_1:IFrameController;
      
      private var UnknownVarFromPollContentDialog_Boolean_1:Boolean = false;
      
      private var UnknownVarFromPollContentDialog_Array_1:Array;
      
      private var UnknownVarFromPollContentDialog_Int_2:int = -1;
      
      private var UnknownVarFromPollContentDialog_Int_3:int = 0;
      
      private var UnknownVarFromPollContentDialog_Int_4:int = -1;
      
      private var UnknownVarFromPollContentDialog_Boolean_2:Boolean = false;
      
      private var UnknownVarFromPollContentDialog_Int_5:int = 0;
      
      private var UnknownVarFromPollContentDialog_PollQuestion_1:PollQuestion = null;
      
      public function PollContentDialog(param1:int, param2:String, param3:Array, param4:PollWidget, param5:Boolean)
      {
         var _loc8_:ITextWindow = null;
         var _loc7_:IWindowModel = null;
         var _loc9_:IWindowModel = null;
         var _loc6_:IWindowModel = null;
         super();
         UnknownVarFromPollContentDialog_Int_1 = param1;
         UnknownVarFromPollContentDialog_Array_1 = param3;
         UnknownVarFromPollContentDialog_PollWidget_1 = param4;
         UnknownVarFromPollContentDialog_Boolean_2 = param5;
         answerableQuestionCount();
         var _loc10_:XmlAsset = UnknownVarFromPollContentDialog_PollWidget_1.assets.getAssetByName("poll_question") as XmlAsset;
         if(_loc10_ != null)
         {
            _window = UnknownVarFromPollContentDialog_PollWidget_1.windowManager.buildFromXML(_loc10_.content as XML) as IFrameController;
            _loc8_ = _window.findChildByName("poll_question_headline") as ITextWindow;
            if(_loc8_)
            {
               _loc8_.text = param2;
            }
            _window.center();
            _loc7_ = _window.findChildByName("header_button_close");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener("WME_CLICK",onClose);
            }
            _loc9_ = _window.findChildByName("poll_question_button_ok");
            if(_loc9_ != null)
            {
               _loc9_.addEventListener("WME_CLICK",onOk);
            }
            _loc6_ = _window.findChildByName("poll_question_cancel");
            if(_loc6_ != null)
            {
               _loc6_.addEventListener("WME_CLICK",onCancel);
            }
         }
      }
      
      public function start() : void
      {
         if(!UnknownVarFromPollContentDialog_Boolean_1)
         {
            UnknownVarFromPollContentDialog_Boolean_1 = true;
            nextQuestion();
         }
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         showCancelConfirm();
      }
      
      private function onOk(param1:WindowEvent) : void
      {
         answerPollQuestion();
      }
      
      private function onCancel(param1:WindowEvent) : void
      {
         showCancelConfirm();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromPollContentDialog_IFrameController_1)
         {
            UnknownVarFromPollContentDialog_IFrameController_1.dispose();
            UnknownVarFromPollContentDialog_IFrameController_1 = null;
         }
         UnknownVarFromPollContentDialog_PollWidget_1 = null;
         UnknownVarFromPollContentDialog_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function nextQuestion() : void
      {
         var _loc5_:ITextWindow = null;
         var _loc1_:IWindowController_1 = null;
         var _loc2_:String = null;
         var _loc4_:IItemListWindow = null;
         var _loc3_:int = 0;
         UnknownVarFromPollContentDialog_PollQuestion_1 = getNextQuestion();
         if(UnknownVarFromPollContentDialog_PollQuestion_1)
         {
            if(_window != null)
            {
               _loc5_ = _window.findChildByName("poll_question_text") as ITextWindow;
               if(_loc5_ != null)
               {
                  _loc5_.text = UnknownVarFromPollContentDialog_PollQuestion_1.questionText;
               }
               _loc5_ = _window.findChildByName("poll_question_number") as ITextWindow;
               if(_loc5_ != null)
               {
                  _loc5_.text = "${poll_question_number}";
                  _loc2_ = _loc5_.text;
                  _loc2_ = _loc2_.replace("%number%",UnknownVarFromPollContentDialog_Int_2 + 1);
                  _loc2_ = _loc2_.replace("%count%",UnknownVarFromPollContentDialog_Int_3);
                  _loc5_.text = _loc2_;
               }
               _loc1_ = _window.findChildByName("poll_question_answer_container") as IWindowController_1;
               if(_loc1_ != null)
               {
                  while(_loc1_.numChildren > 0)
                  {
                     _loc1_.getChildAt(0).dispose();
                  }
                  _loc1_.invalidate();
               }
               switch(UnknownVarFromPollContentDialog_PollQuestion_1.questionType - 1)
               {
                  case 0:
                     populateRadionButtonType(_loc1_,UnknownVarFromPollContentDialog_PollQuestion_1.questionChoices);
                     break;
                  case 1:
                     populateCheckBoxType(_loc1_,UnknownVarFromPollContentDialog_PollQuestion_1.questionChoices);
                     break;
                  case 2:
                     populateTextLineType(_loc1_);
                     break;
                  case 3:
                     populateTextAreaType(_loc1_);
                     break;
                  default:
                     nextQuestion();
               }
               _loc4_ = _window.findChildByName("poll_content_wrapper") as IItemListWindow;
               if(_loc4_ != null)
               {
                  _loc3_ = _loc4_.scrollableRegion.height - _loc4_.visibleRegion.height;
                  _window.height += _loc3_;
                  _window.center();
               }
            }
         }
         else
         {
            UnknownVarFromPollContentDialog_PollWidget_1.pollFinished(UnknownVarFromPollContentDialog_Int_1);
         }
      }
      
      private function getNextQuestion() : PollQuestion
      {
         var _loc1_:PollQuestion = null;
         var _loc3_:int = 0;
         var _loc2_:PollQuestion = null;
         if(UnknownVarFromPollContentDialog_Boolean_2 && UnknownVarFromPollContentDialog_Int_4 >= 0 && UnknownVarFromPollContentDialog_Int_5 != 0)
         {
            _loc1_ = UnknownVarFromPollContentDialog_Array_1[UnknownVarFromPollContentDialog_Int_4];
            _loc3_ = 0;
            while(_loc3_ < _loc1_.children.length)
            {
               _loc2_ = _loc1_.children[_loc3_];
               if(_loc2_ && _loc2_.questionCategory == UnknownVarFromPollContentDialog_Int_5)
               {
                  UnknownVarFromPollContentDialog_Int_4 = -1;
                  return _loc2_;
               }
               _loc3_++;
            }
         }
         UnknownVarFromPollContentDialog_Int_2++;
         if(UnknownVarFromPollContentDialog_Int_2 < UnknownVarFromPollContentDialog_Array_1.length)
         {
            UnknownVarFromPollContentDialog_Int_4 = UnknownVarFromPollContentDialog_Int_2;
            return UnknownVarFromPollContentDialog_Array_1[UnknownVarFromPollContentDialog_Int_2];
         }
         return null;
      }
      
      private function populateRadionButtonType(param1:IWindowController_1, param2:Vector.<PollChoice>) : void
      {
         var _loc3_:XmlAsset = UnknownVarFromPollContentDialog_PollWidget_1.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_radiobutton_input\"!");
         }
         var _loc4_:IWindowController_1 = UnknownVarFromPollContentDialog_PollWidget_1.windowManager.buildFromXML(_loc3_.content as XML) as IWindowController_1;
         if(_loc4_ != null)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function resolveRadionButtonTypeAnswer(param1:PollQuestion) : Array
      {
         var _loc3_:ISelectorWindow = null;
         var _loc4_:ISelectableWindow = null;
         var _loc5_:PollChoice = null;
         var _loc2_:Array = [];
         if(_window != null)
         {
            _loc3_ = _window.findChildByName("poll_answer_selector") as ISelectorWindow;
            if(_loc3_)
            {
               _loc4_ = _loc3_.getSelected();
               if(_loc4_)
               {
                  _loc5_ = param1.questionChoices[_loc4_.id];
                  if(UnknownVarFromPollContentDialog_Boolean_2)
                  {
                     UnknownVarFromPollContentDialog_Int_5 = _loc5_.choiceType;
                  }
                  else
                  {
                     UnknownVarFromPollContentDialog_Int_5 = 0;
                  }
                  _loc2_.push(_loc5_.value);
               }
            }
         }
         return _loc2_;
      }
      
      private function populateCheckBoxType(param1:IWindowController_1, param2:Vector.<PollChoice>) : void
      {
         var _loc3_:XmlAsset = UnknownVarFromPollContentDialog_PollWidget_1.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_checkbox_input\"!");
         }
         var _loc4_:IWindowController_1 = UnknownVarFromPollContentDialog_PollWidget_1.windowManager.buildFromXML(_loc3_.content as XML) as IWindowController_1;
         if(_loc4_ != null)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function resolveCheckBoxTypeAnswer(param1:PollQuestion) : Array
      {
         var _loc5_:IItemListWindow = null;
         var _loc3_:int = 0;
         var _loc6_:IWindowController_1 = null;
         var _loc4_:UnknownICoreWindowComponents2 = null;
         var _loc2_:Array = [];
         if(_window != null)
         {
            _loc5_ = _window.findChildByName("poll_answer_itemlist") as IItemListWindow;
            if(_loc5_ != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.numListItems)
               {
                  _loc6_ = _loc5_.getListItemAt(_loc3_) as IWindowController_1;
                  if(_loc6_ != null)
                  {
                     _loc4_ = _loc6_.findChildByName("poll_answer_checkbox") as UnknownICoreWindowComponents2;
                     if(_loc4_ != null)
                     {
                        if(_loc4_.testStateFlag(8))
                        {
                           _loc2_.push(param1.questionChoices[_loc3_].value);
                        }
                     }
                  }
                  _loc3_++;
               }
            }
         }
         return _loc2_;
      }
      
      private function populateSelectionList(param1:Vector.<PollChoice>, param2:IWindowController_1) : void
      {
         var _loc7_:IWindowController_1 = null;
         var _loc4_:int = 0;
         var _loc5_:ITextWindow = null;
         var _loc3_:IWindowModel = null;
         var _loc6_:IItemListWindow = param2.findChildByName("poll_answer_itemlist") as IItemListWindow;
         if(_loc6_ != null)
         {
            _loc7_ = param2.findChildByName("poll_answer_entity") as IWindowController_1;
            if(_loc7_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < param1.length - 1)
               {
                  _loc4_++;
                  _loc6_.addListItem(_loc7_.clone());
               }
               _loc4_ = 0;
               while(_loc4_ < param1.length)
               {
                  _loc7_ = _loc6_.getListItemAt(_loc4_) as IWindowController_1;
                  _loc5_ = _loc7_.findChildByName("poll_answer_entity_text") as ITextWindow;
                  if(_loc5_)
                  {
                     _loc5_.text = param1[_loc4_].choiceText;
                  }
                  _loc3_ = _loc7_.findChildByTag("POLL_SELECTABLE_ITEM");
                  if(_loc3_)
                  {
                     _loc3_.id = _loc4_;
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function populateTextLineType(param1:IWindowController_1) : void
      {
         var _loc2_:XmlAsset = UnknownVarFromPollContentDialog_PollWidget_1.assets.getAssetByName("poll_answer_text_input") as XmlAsset;
         if(!_loc2_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_text_input\"!");
         }
         param1.addChild(UnknownVarFromPollContentDialog_PollWidget_1.windowManager.buildFromXML(_loc2_.content as XML));
      }
      
      private function resolveTextLineTypeAnswer() : Array
      {
         var _loc2_:ITextWindow = null;
         var _loc1_:Array = [];
         if(_window != null)
         {
            _loc2_ = _window.findChildByName("poll_answer_input") as ITextWindow;
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.text);
            }
            return _loc1_;
         }
         throw new Error("Invalid or disposed poll dialog!");
      }
      
      private function populateTextAreaType(param1:IWindowController_1) : void
      {
         populateTextLineType(param1);
      }
      
      private function resolveTextAreaTypeAnswer() : Array
      {
         return resolveTextLineTypeAnswer();
      }
      
      private function cancelPoll() : void
      {
         UnknownVarFromPollContentDialog_PollWidget_1.pollCancelled(UnknownVarFromPollContentDialog_Int_1);
      }
      
      private function answerPollQuestion() : void
      {
         var answerArray:Array;
         var answers:Array;
         var message:RoomWidgetPollMessage;
         var answerValue:int;
         var question:PollQuestion = null;
         if(UnknownVarFromPollContentDialog_Boolean_2 && UnknownVarFromPollContentDialog_PollQuestion_1)
         {
            question = UnknownVarFromPollContentDialog_PollQuestion_1;
         }
         else
         {
            question = UnknownVarFromPollContentDialog_Array_1[UnknownVarFromPollContentDialog_Int_2];
         }
         UnknownVarFromPollContentDialog_Int_5 = 0;
         switch(question.questionType - 1)
         {
            case 0:
               answerArray = resolveRadionButtonTypeAnswer(question);
               break;
            case 1:
               answerArray = resolveCheckBoxTypeAnswer(question);
               if(answerArray.length < 0)
               {
                  UnknownVarFromPollContentDialog_PollWidget_1.windowManager.alert("${win_error}","${poll_alert_answer_missing}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               if(answerArray.length > question.questionChoices.length)
               {
                  UnknownVarFromPollContentDialog_PollWidget_1.windowManager.alert("${win_error}","${poll_alert_invalid_selection}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               break;
            case 2:
               answerArray = resolveTextLineTypeAnswer();
               break;
            case 3:
               answerArray = resolveTextAreaTypeAnswer();
               break;
            default:
               throw new Error("Unknown poll question type: " + question.questionType + "!");
         }
         answers = [];
         message = new RoomWidgetPollMessage("RWPM_ANSWER",UnknownVarFromPollContentDialog_Int_1);
         message.questionId = question.questionId;
         if(question.questionChoices.length > 0)
         {
            for each(answerValue in answerArray)
            {
               answers.push(answerValue);
            }
         }
         else
         {
            answers.push(answerArray);
         }
         message.answers = answers;
         UnknownVarFromPollContentDialog_PollWidget_1.messageListener.processWidgetMessage(message);
         nextQuestion();
      }
      
      private function showCancelConfirm() : void
      {
         var _loc4_:XmlAsset = null;
         var _loc2_:IWindowModel = null;
         var _loc3_:IWindowModel = null;
         var _loc1_:IWindowModel = null;
         if(!UnknownVarFromPollContentDialog_IFrameController_1)
         {
            _loc4_ = UnknownVarFromPollContentDialog_PollWidget_1.assets.getAssetByName("poll_cancel_confirm") as XmlAsset;
            UnknownVarFromPollContentDialog_IFrameController_1 = UnknownVarFromPollContentDialog_PollWidget_1.windowManager.buildFromXML(_loc4_.content as XML,2) as IFrameController;
            UnknownVarFromPollContentDialog_IFrameController_1.center();
            _loc2_ = UnknownVarFromPollContentDialog_IFrameController_1.findChildByName("header_button_close");
            if(_loc2_ != null)
            {
               _loc2_.addEventListener("WME_CLICK",onCancelPollClose);
            }
            _loc3_ = UnknownVarFromPollContentDialog_IFrameController_1.findChildByName("poll_cancel_confirm_button_ok");
            if(_loc3_ != null)
            {
               _loc3_.addEventListener("WME_CLICK",onCancelPollOk);
            }
            _loc1_ = UnknownVarFromPollContentDialog_IFrameController_1.findChildByName("poll_cancel_confirm_button_cancel");
            if(_loc1_ != null)
            {
               _loc1_.addEventListener("WME_CLICK",onCancelPollCancel);
            }
         }
      }
      
      private function hideCancelConfirm() : void
      {
         if(UnknownVarFromPollContentDialog_IFrameController_1 != null)
         {
            UnknownVarFromPollContentDialog_IFrameController_1.dispose();
            UnknownVarFromPollContentDialog_IFrameController_1 = null;
         }
      }
      
      private function onCancelPollClose(param1:WindowEvent) : void
      {
         hideCancelConfirm();
      }
      
      private function onCancelPollOk(param1:WindowEvent) : void
      {
         hideCancelConfirm();
         cancelPoll();
      }
      
      private function onCancelPollCancel(param1:WindowEvent) : void
      {
         hideCancelConfirm();
      }
      
      private function answerableQuestionCount() : void
      {
         UnknownVarFromPollContentDialog_Int_3 = UnknownVarFromPollContentDialog_Array_1.length;
         for each(var _loc1_ in UnknownVarFromPollContentDialog_Array_1)
         {
            if(_loc1_.children.length > 0)
            {
               UnknownVarFromPollContentDialog_Int_3++;
            }
         }
      }
   }
}

