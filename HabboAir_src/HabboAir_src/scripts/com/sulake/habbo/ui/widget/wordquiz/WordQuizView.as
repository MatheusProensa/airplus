package com.sulake.habbo.ui.widget.wordquiz
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class WordQuizView
   {
      public static const STATE_QUESTION:int = 0;
      
      public static const STATE_RESULT:int = 1;
      
      private static const CONTAINER_IN_BOTTOM:Boolean = false;
      
      private static var UnknownVarFromWordQuizView_Int_1:int;
      
      private var UnknownVarFromWordQuizView_WordQuizWidget_1:WordQuizWidget;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWordQuizView_Timer_1:Timer;
      
      private var UnknownVarFromWordQuizView_String_1:String;
      
      public function WordQuizView(param1:WordQuizWidget)
      {
         super();
         UnknownVarFromWordQuizView_WordQuizWidget_1 = param1;
         UnknownVarFromWordQuizView_Int_1 = UnknownVarFromWordQuizView_WordQuizWidget_1.handler.container.config.getInteger("poll.word.quiz.result.view.seconds",4) * 1000;
      }
      
      public function dispose() : void
      {
         UnknownVarFromWordQuizView_WordQuizWidget_1 = null;
         removeWindow();
         if(_window)
         {
            if(_window.desktop)
            {
               _window.desktop.removeEventListener("WE_RESIZED",onDesktopResized);
            }
            _window.dispose();
            _window = null;
         }
      }
      
      private function getCorrectTextWidth(param1:int, param2:String = null) : int
      {
         var _loc4_:String = null;
         var _loc5_:IWindowController_1 = null;
         if(param1 == 0)
         {
            _loc4_ = "wordquiz_question_xml";
         }
         else
         {
            _loc4_ = "wordquiz_result_xml";
         }
         _loc5_ = UnknownVarFromWordQuizView_WordQuizWidget_1.windowManager.buildFromXML(UnknownVarFromWordQuizView_WordQuizWidget_1.assets.getAssetByName(_loc4_).content as XML) as IWindowController_1;
         if(_loc5_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _loc5_.findChildByName("quiz_topic").caption = param2;
         _loc5_.findChildByName("quiz_topic").width = 660;
         var _loc3_:int = int(ITextWindow(_loc5_.findChildByName("quiz_topic")).textWidth);
         _loc5_.dispose();
         return _loc3_;
      }
      
      public function createWindow(param1:int, param2:String = null) : void
      {
         var _loc3_:String = null;
         removeWindow();
         if(param1 == 0)
         {
            _loc3_ = "wordquiz_question_xml";
         }
         else
         {
            _loc3_ = "wordquiz_result_xml";
         }
         _window = UnknownVarFromWordQuizView_WordQuizWidget_1.windowManager.buildFromXML(UnknownVarFromWordQuizView_WordQuizWidget_1.assets.getAssetByName(_loc3_).content as XML) as IWindowController_1;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc4_:IWindowModel = _window.findChildByName("button_like");
         if(_loc4_)
         {
            _loc4_.addEventListener("WME_CLICK",onLike);
         }
         _loc4_ = _window.findChildByName("button_dislike");
         if(_loc4_)
         {
            _loc4_.addEventListener("WME_CLICK",onDislike);
         }
         if(param2 != null)
         {
            UnknownVarFromWordQuizView_String_1 = param2;
         }
         _window.findChildByName("quiz_topic").caption = UnknownVarFromWordQuizView_String_1;
         _window.findChildByName("quiz_topic").width = Math.min(660,getCorrectTextWidth(param1,UnknownVarFromWordQuizView_String_1) + 6);
         _window.findChildByName("quiz_topic").y = 3;
         positionWindow();
         _window.desktop.addEventListener("WE_RESIZED",onDesktopResized);
      }
      
      public function removeWindow() : void
      {
         if(!_window || _window.numChildren == 0)
         {
            return;
         }
         _window.desktop.addEventListener("WE_RESIZED",onDesktopResized);
         _window.dispose();
         _window = null;
         if(UnknownVarFromWordQuizView_Timer_1)
         {
            UnknownVarFromWordQuizView_Timer_1.reset();
            UnknownVarFromWordQuizView_Timer_1 = null;
         }
      }
      
      public function get mainWindow() : IWindowModel
      {
         return _window;
      }
      
      public function updateCounter(param1:String) : void
      {
         if(!_window || !_window.findChildByName("countdown"))
         {
            return;
         }
         if(param1 == "0")
         {
            param1 = "";
         }
         _window.findChildByName("countdown").caption = param1;
      }
      
      public function updateResults(param1:Map) : void
      {
         if(!_window || !param1)
         {
            return;
         }
         var _loc3_:int = param1["0"] != null ? param1.getValue("0") : 0;
         var _loc2_:ILabelWindow = _window.findChildByName("lbl_dislike_count") as ILabelWindow;
         if(_loc2_)
         {
            _loc2_.text = _loc3_.toString();
         }
         _loc3_ = param1["1"] != null ? param1.getValue("1") : 0;
         _loc2_ = _window.findChildByName("lbl_like_count") as ILabelWindow;
         if(_loc2_)
         {
            _loc2_.text = _loc3_.toString();
         }
      }
      
      public function displayResults(param1:Map) : void
      {
         createWindow(1);
         updateResults(param1);
         UnknownVarFromWordQuizView_Timer_1 = new Timer(UnknownVarFromWordQuizView_Int_1);
         UnknownVarFromWordQuizView_Timer_1.addEventListener("timer",onWaitTimer);
         UnknownVarFromWordQuizView_Timer_1.start();
      }
      
      private function onWaitTimer(param1:TimerEvent) : void
      {
         removeWindow();
      }
      
      private function onLike(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWordQuizView_WordQuizWidget_1.sendAnswer(1);
      }
      
      private function onDislike(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWordQuizView_WordQuizWidget_1.sendAnswer(0);
      }
      
      private function onDesktopResized(param1:WindowEvent) : void
      {
         positionWindow();
      }
      
      private function positionWindow() : void
      {
         if(!_window || _window.numChildren == 0)
         {
            return;
         }
         var _loc1_:IWindowModel = _window.getChildAt(0);
         _window.x = _window.desktop.width / 2 - _loc1_.width / 2;
         _window.y = 6;
      }
   }
}

