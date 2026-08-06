package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class PollWidget extends RoomWidgetBase
   {
      private var UnknownVarFromPollWidget_Map_1:Map;
      
      public function PollWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
         UnknownVarFromPollWidget_Map_1 = new Map();
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:PollSession = null;
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromPollWidget_Map_1 != null)
         {
            _loc2_ = int(UnknownVarFromPollWidget_Map_1.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = UnknownVarFromPollWidget_Map_1.getWithIndex(0) as PollSession;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            UnknownVarFromPollWidget_Map_1.dispose();
            UnknownVarFromPollWidget_Map_1 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPUW_OFFER",showPollOffer);
         param1.addEventListener("RWPUW_ERROR",showPollError);
         param1.addEventListener("RWPUW_CONTENT",showPollContent);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPUW_OFFER",showPollOffer);
         param1.removeEventListener("RWPUW_ERROR",showPollError);
         param1.removeEventListener("RWPUW_CONTENT",showPollContent);
      }
      
      private function showPollOffer(param1:Event) : void
      {
         var _loc4_:int = int(RoomWidgetPollUpdateEvent(param1).id);
         if(windowManager.LilithCustomsInstance.OnPollOffer(_loc4_) == false)
         {
            return;
         }
         var _loc3_:PollSession = UnknownVarFromPollWidget_Map_1.getValue(_loc4_) as PollSession;
         var _loc2_:String = RoomWidgetPollUpdateEvent(param1).summary;
         var _loc5_:String = RoomWidgetPollUpdateEvent(param1).headline;
         if(!_loc3_)
         {
            _loc3_ = new PollSession(_loc4_,this);
            UnknownVarFromPollWidget_Map_1.add(_loc4_,_loc3_);
            _loc3_.showOffer(_loc5_,_loc2_);
         }
         else
         {
            Logger.log("Poll with given id already exists!");
            _loc3_.showOffer(_loc5_,_loc2_);
         }
      }
      
      private function showPollError(param1:Event) : void
      {
         var e:Event = param1;
         windowManager.alert("${win_error}",RoomWidgetPollUpdateEvent(e).summary,0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function showPollContent(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PollSession = null;
         var _loc3_:RoomWidgetPollUpdateEvent = param1 as RoomWidgetPollUpdateEvent;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.id;
            _loc2_ = UnknownVarFromPollWidget_Map_1.getValue(_loc4_) as PollSession;
            if(_loc2_ != null)
            {
               _loc2_.showContent(_loc3_.startMessage,_loc3_.endMessage,_loc3_.questionArray,_loc3_.npsPoll);
            }
         }
      }
      
      public function pollFinished(param1:int) : void
      {
         var _loc2_:PollSession = UnknownVarFromPollWidget_Map_1.getValue(param1) as PollSession;
         if(_loc2_ != null)
         {
            _loc2_.showThanks();
            _loc2_.dispose();
            UnknownVarFromPollWidget_Map_1.remove(param1);
         }
      }
      
      public function pollCancelled(param1:int) : void
      {
         var _loc2_:PollSession = UnknownVarFromPollWidget_Map_1.getValue(param1) as PollSession;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            UnknownVarFromPollWidget_Map_1.remove(param1);
         }
      }
   }
}

