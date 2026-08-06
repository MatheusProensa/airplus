package com.sulake.habbo.ui.widget.wordquiz
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.WordQuizWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetWordQuizUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class WordQuizWidget extends RoomWidgetBase
   {
      private static const ASSET_NAME_LIKE:String = "wordquiz_like_xml";
      
      private static const ASSET_NAME_DISLIKE:String = "wordquiz_unlike_xml";
      
      private static const SIGN_FADE_IN_TIME:int = 750;
      
      private static const SIGN_FADE_OUT_TIME:int = 750;
      
      private static const UPDATE_FREQUENCY:int = 40;
      
      public static const VALUE_KEY_DISLIKE:String = "0";
      
      public static const VALUE_KEY_LIKE:String = "1";
      
      private var UnknownVarFromWordQuizWidget_WordQuizView_1:WordQuizView;
      
      private var UnknownVarFromWordQuizWidget_Timer_1:Timer;
      
      private var UnknownVarFromWordQuizWidget_Timer_2:Timer;
      
      private var UnknownVarFromWordQuizWidget_Timer_3:Timer;
      
      private var UnknownVarFromWordQuizWidget_Int_1:int = 0;
      
      private var _showResultTime:int;
      
      private var _countdown:int = 0;
      
      private var UnknownVarFromWordQuizWidget_Int_2:int;
      
      private var UnknownVarFromWordQuizWidget_Dictionary_1:Dictionary;
      
      private var UnknownVarFromWordQuizWidget_Int_3:int;
      
      private var _showSignCounters:Dictionary = new Dictionary();
      
      private var _answerWindows:Vector.<IWindowController_1> = new Vector.<IWindowController_1>(0);
      
      private var UnknownVarFromWordQuizWidget_Vector_1:Vector.<IWindowController_1> = new Vector.<IWindowController_1>(0);
      
      private var UnknownVarFromWordQuizWidget_Vector_2:Vector.<IWindowController_1> = new Vector.<IWindowController_1>(0);
      
      private var UnknownVarFromWordQuizWidget_Boolean_1:Boolean;
      
      public function WordQuizWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(handler,param2,param3,param4);
         _widgetHandler = param1;
         UnknownVarFromWordQuizWidget_WordQuizView_1 = new WordQuizView(this);
         _showResultTime = handler.container.config.getInteger("poll.word.quiz.answer.bubble.seconds",3) * 1000;
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return !!UnknownVarFromWordQuizWidget_WordQuizView_1 ? UnknownVarFromWordQuizWidget_WordQuizView_1.mainWindow : null;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPUW_NEW_QUESTION",newQuestion);
         param1.addEventListener("RWPUW_QUESTION_ANSWERED",answeredQuestion);
         param1.addEventListener("RWPUW_QUESION_FINSIHED",questionFinished);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPUW_NEW_QUESTION",newQuestion);
         param1.removeEventListener("RWPUW_QUESTION_ANSWERED",answeredQuestion);
         param1.removeEventListener("RWPUW_QUESION_FINSIHED",questionFinished);
         super.unregisterUpdateEvents(param1);
      }
      
      public function get handler() : WordQuizWidgetHandler
      {
         return _widgetHandler as WordQuizWidgetHandler;
      }
      
      override public function dispose() : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc1_:int = 0;
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromWordQuizWidget_WordQuizView_1)
         {
            UnknownVarFromWordQuizWidget_WordQuizView_1.dispose();
            UnknownVarFromWordQuizWidget_WordQuizView_1 = null;
         }
         if(UnknownVarFromWordQuizWidget_Timer_1)
         {
            UnknownVarFromWordQuizWidget_Timer_1.reset();
            UnknownVarFromWordQuizWidget_Timer_1 = null;
         }
         if(UnknownVarFromWordQuizWidget_Timer_2)
         {
            UnknownVarFromWordQuizWidget_Timer_2.reset();
            UnknownVarFromWordQuizWidget_Timer_2 = null;
         }
         if(UnknownVarFromWordQuizWidget_Timer_3)
         {
            UnknownVarFromWordQuizWidget_Timer_3.reset();
            UnknownVarFromWordQuizWidget_Timer_3 = null;
         }
         if(windowManager)
         {
            if(_answerWindows)
            {
               _loc1_ = 0;
               while(_loc1_ < _answerWindows.length)
               {
                  _loc2_ = _answerWindows[_loc1_] as IWindowController_1;
                  if(_loc2_)
                  {
                     windowManager.removeWindow(_loc2_.name);
                  }
                  _loc1_++;
               }
            }
            for each(_loc2_ in UnknownVarFromWordQuizWidget_Vector_1)
            {
               _loc2_.destroy();
            }
            UnknownVarFromWordQuizWidget_Vector_1.length = 0;
            for each(_loc2_ in UnknownVarFromWordQuizWidget_Vector_2)
            {
               _loc2_.destroy();
            }
            UnknownVarFromWordQuizWidget_Vector_2.length = 0;
         }
         super.dispose();
      }
      
      private function newQuestion(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         UnknownVarFromWordQuizWidget_Int_2 = param1.id;
         UnknownVarFromWordQuizWidget_Dictionary_1 = param1.question;
         UnknownVarFromWordQuizWidget_Boolean_1 = false;
         _showSignCounters = new Dictionary();
         showNewQuestion(UnknownVarFromWordQuizWidget_Dictionary_1,param1.duration);
      }
      
      private function questionFinished(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var _loc2_:int = 0;
         clearTimers();
         if(UnknownVarFromWordQuizWidget_WordQuizView_1 && UnknownVarFromWordQuizWidget_Dictionary_1 && UnknownVarFromWordQuizWidget_Dictionary_1.id == param1.questionId)
         {
            UnknownVarFromWordQuizWidget_WordQuizView_1.displayResults(param1.answerCounts);
         }
         _loc2_ = 0;
         while(_loc2_ < _answerWindows.length)
         {
            poolWindow(_answerWindows[_loc2_].name);
            _loc2_++;
         }
         _answerWindows.length = 0;
      }
      
      private function poolWindow(param1:String) : void
      {
         if(windowManager == null)
         {
            return;
         }
         windowManager.removeWindow(param1);
      }
      
      private function answeredQuestion(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var _loc7_:IWindowController_1 = null;
         if(UnknownVarFromWordQuizWidget_WordQuizView_1)
         {
            UnknownVarFromWordQuizWidget_WordQuizView_1.updateResults(param1.answerCounts);
         }
         var _loc8_:int = param1.userId;
         var _loc9_:String = param1.value;
         var _loc3_:Vector.<IWindowController_1> = _loc9_ == "1" ? UnknownVarFromWordQuizWidget_Vector_1 : UnknownVarFromWordQuizWidget_Vector_2;
         var _loc4_:String = _loc9_ == "1" ? "wordquiz_like_xml" : "wordquiz_unlike_xml";
         var _loc5_:String = UnknownVarFromWordQuizWidget_Int_2 + "_" + _loc8_ + "_" + _loc4_;
         if(_loc3_.length)
         {
            _loc7_ = _loc3_.pop();
         }
         else
         {
            _loc7_ = windowManager.buildFromXML(assets.getAssetByName(_loc4_).content as XML) as IWindowController_1;
         }
         _loc7_.name = _loc5_;
         _answerWindows.push(_loc7_);
         _showSignCounters[_loc5_] = _showResultTime + 750 + 750;
         var _loc6_:Rectangle = getAvatarRect(_loc8_);
         if(_loc6_)
         {
            _loc7_.x = _loc6_.left + 20;
            _loc7_.y = _loc6_.top - 20;
         }
         if(!UnknownVarFromWordQuizWidget_Timer_3)
         {
            UnknownVarFromWordQuizWidget_Timer_3 = new Timer(40);
            UnknownVarFromWordQuizWidget_Timer_3.addEventListener("timer",onLocationTimer);
            UnknownVarFromWordQuizWidget_Timer_3.start();
         }
         var _loc2_:UnknownICoreWindowComponents6 = _loc7_.getChildByName("colored") as UnknownICoreWindowComponents6;
         if(_loc2_)
         {
            _loc2_.blend = 0;
         }
      }
      
      private function onLocationTimer(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:IWindowController_1 = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:Rectangle = null;
         _loc3_ = 0;
         while(_loc3_ < _answerWindows.length)
         {
            _loc5_ = _answerWindows[_loc3_];
            if(_loc5_)
            {
               _loc2_ = String(_answerWindows[_loc3_].name).split("_");
               if(_loc2_.length > 1)
               {
                  _loc6_ = int(_loc2_[1]);
                  _loc4_ = getAvatarRect(_loc6_);
                  if(!_loc4_)
                  {
                     poolWindow(_answerWindows[_loc3_].name);
                     return;
                  }
                  _loc5_.x = _loc4_.left + 29;
                  _loc5_.y = _loc4_.top - 11;
                  handleSignWindowVisibility(_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      private function handleSignWindowVisibility(param1:IWindowController_1) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:UnknownICoreWindowComponents6 = param1.getChildByName("colored") as UnknownICoreWindowComponents6;
         var _loc3_:IRegionWindow = param1.getChildByName("button_like") as IRegionWindow;
         if(_showSignCounters.hasOwnProperty(param1.name) && _loc2_ && _loc3_)
         {
            _loc4_ = int(_showSignCounters[param1.name]);
            _loc4_ = _loc4_ - 40;
            _showSignCounters[param1.name] = _loc4_;
            if(_loc4_ > _showResultTime + 750)
            {
               _loc5_ = 0.1875;
               _loc2_.blend += _loc5_;
               _loc3_.blend = _loc2_.blend;
            }
            else if(_loc4_ > 750)
            {
               _loc2_.blend = 1;
               _loc3_.blend = 1;
            }
            else if(_loc4_ < 750 && _loc4_ > 0)
            {
               _loc5_ = 750 / 40;
               param1.blend -= _loc5_ * 0.01;
               param1.y -= 20 + (70 - param1.blend * 120);
            }
            else if(_loc4_ < 0)
            {
               param1.y -= 20 + (70 - param1.blend * 120);
               poolWindow(param1.name);
            }
         }
      }
      
      private function getAvatarRect(param1:int) : Rectangle
      {
         if(!handler || !handler.container || !handler.container.roomSession || !handler.container.roomEngine)
         {
            return null;
         }
         var _loc3_:int = handler.container.roomSession.roomId;
         var _loc2_:IUserData = handler.container.roomSessionManager.getSession(_loc3_).userDataManager.getUserData(param1);
         if(_loc2_)
         {
            return handler.container.roomEngine.getRoomObjectBoundingRectangle(_loc3_,_loc2_.roomObjectId,100,handler.container.getFirstCanvasId());
         }
         return null;
      }
      
      private function onCountdownDownTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromWordQuizWidget_Timer_2 == null)
         {
            return;
         }
         _countdown--;
         UnknownVarFromWordQuizWidget_WordQuizView_1.updateCounter(String(_countdown));
         if(_countdown == 0)
         {
            clearTimers();
            UnknownVarFromWordQuizWidget_WordQuizView_1.removeWindow();
         }
      }
      
      private function showNewQuestion(param1:Dictionary, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         UnknownVarFromWordQuizWidget_WordQuizView_1.createWindow(0,param1.content);
         UnknownVarFromWordQuizWidget_Int_1++;
         _countdown = 4;
         UnknownVarFromWordQuizWidget_Int_3 = param1.id;
         if(param2 > 0)
         {
            UnknownVarFromWordQuizWidget_Timer_2 = new Timer(1000);
            _countdown = param2 / 1000;
            UnknownVarFromWordQuizWidget_Timer_2.addEventListener("timer",onCountdownDownTimer);
            UnknownVarFromWordQuizWidget_Timer_2.start();
            UnknownVarFromWordQuizWidget_Timer_3 = new Timer(40);
            UnknownVarFromWordQuizWidget_Timer_3.addEventListener("timer",onLocationTimer);
            UnknownVarFromWordQuizWidget_Timer_3.start();
            UnknownVarFromWordQuizWidget_WordQuizView_1.updateCounter(String(_countdown));
         }
      }
      
      private function clearTimers() : void
      {
         if(UnknownVarFromWordQuizWidget_Timer_2)
         {
            UnknownVarFromWordQuizWidget_Timer_2.reset();
            UnknownVarFromWordQuizWidget_Timer_2 = null;
         }
         if(UnknownVarFromWordQuizWidget_Timer_3)
         {
            UnknownVarFromWordQuizWidget_Timer_3.reset();
            UnknownVarFromWordQuizWidget_Timer_3 = null;
         }
      }
      
      public function sendAnswer(param1:int) : void
      {
         UnknownVarFromWordQuizWidget_WordQuizView_1.removeWindow();
         if(UnknownVarFromWordQuizWidget_Boolean_1)
         {
            return;
         }
         var _loc3_:RoomWidgetPollMessage = new RoomWidgetPollMessage("RWPM_ANSWER",UnknownVarFromWordQuizWidget_Int_2);
         _loc3_.questionId = UnknownVarFromWordQuizWidget_Dictionary_1["id"] as int;
         var _loc2_:Array = [];
         _loc2_.push("" + param1);
         _loc3_.answers = _loc2_;
         messageListener.processWidgetMessage(_loc3_);
         UnknownVarFromWordQuizWidget_Boolean_1 = true;
         UnknownVarFromWordQuizWidget_WordQuizView_1.createWindow(1);
      }
   }
}

