package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.recycler.FurniSlotItem;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.IRecyclerVisualization;
   import com.sulake.habbo.catalog.viewer.CatalogObjectMover;
   import com.sulake.habbo.catalog.viewer.widgets.franksemotions.FrankRecyclerEmotion;
   import com.sulake.habbo.catalog.viewer.widgets.utils.RecyclerEngineAnimator;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class RecyclerCatalogWidget extends CatalogWidget implements ICatalogWidget, IRecyclerVisualization, UnknownIHabboRoom1
   {
      private var UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1:CatalogObjectMover;
      
      private var _awaitingImages:Dictionary;
      
      private var UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1:RecyclerEngineAnimator;
      
      private var UnknownVarFromRecyclerCatalogWidget_Timer_1:Timer;
      
      public function RecyclerCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      private function get recycler() : IRecycler
      {
         return page.viewer.catalog.getRecycler();
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 != null)
         {
            UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.dispose();
            UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 = null;
         }
         if(recycler != null)
         {
            recycler.cancel();
         }
         if(UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1 != null)
         {
            UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1.dispose();
            UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1 = null;
         }
         if(UnknownVarFromRecyclerCatalogWidget_Timer_1 != null)
         {
            stopTimer();
         }
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("recyclerWidget");
         renderSlotGraphics();
         renderDucketCost();
         var _loc2_:IWindowModel = window.findChildByName("recycler_recycle");
         _loc2_.addEventListener("WME_CLICK",onRecycleButtonClick);
         var _loc1_:IWindowModel = window.findChildByName("abort_region");
         _loc1_.addEventListener("WME_CLICK",onAbortClick);
         patFrankButton.addEventListener("WME_CLICK",onPatFrank);
         abortButtonVisible = false;
         UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1 = new RecyclerEngineAnimator(window.findChildByName("pointer_arrow") as IStaticBitmapWrapperWindow,window.parent.findChildByName("recycle_machine") as IStaticBitmapWrapperWindow,onAnimationComplete);
         if(recycler == null)
         {
            return false;
         }
         recycler.init(this);
         return true;
      }
      
      private function onPatFrank(param1:WindowMouseEvent) : void
      {
         var _loc2_:FrankRecyclerEmotion = new FrankRecyclerEmotion(emoji2BitmapTemplate);
         _loc2_.start(disabledBorder);
      }
      
      public function updateUI() : void
      {
         var _loc1_:IWindowModel = window;
         while(_loc1_ != null)
         {
            _loc1_.procedure = onMainContainerEvent;
            _loc1_.mouseThreshold = 0;
            _loc1_ = _loc1_.parent;
         }
         var _loc2_:IWindowModel = (window.parent as IWindowController_1).findChildByName("catalog.header.description");
         if(_loc2_ != null)
         {
            _loc2_.caption = "${recycler.info.ready}";
         }
         disabledBorder.visible = recycler.recyclerDisabled;
         updateRecycleButton();
      }
      
      private function startTimer() : void
      {
         UnknownVarFromRecyclerCatalogWidget_Timer_1 = new Timer(1000);
         UnknownVarFromRecyclerCatalogWidget_Timer_1.addEventListener("timer",onTimerTick);
         UnknownVarFromRecyclerCatalogWidget_Timer_1.start();
      }
      
      private function stopTimer() : void
      {
         if(UnknownVarFromRecyclerCatalogWidget_Timer_1)
         {
            UnknownVarFromRecyclerCatalogWidget_Timer_1.stop();
            UnknownVarFromRecyclerCatalogWidget_Timer_1.removeEventListener("timer",onTimerTick);
            UnknownVarFromRecyclerCatalogWidget_Timer_1 = null;
         }
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         updateRecycleButton();
         if(recycler.secondsToWait() <= 0)
         {
            stopTimer();
         }
      }
      
      private function renderSlotGraphics() : void
      {
         var _loc3_:int = 0;
         var _loc1_:IBitmapWrapperController = null;
         var _loc2_:BitmapData = getAssetBitmapData("ctlg_recycler_slot_bg");
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = 1;
         while(_loc3_ <= recycler.numberOfSlots)
         {
            _loc1_ = window.findChildByName("slot_bg_" + _loc3_) as IBitmapWrapperController;
            if(_loc1_ != null)
            {
               _loc1_.bitmap = _loc2_.clone();
               _loc1_.procedure = onSlotMouseEvent;
               _loc1_.mouseThreshold = 0;
            }
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= recycler.numberOfSlots)
         {
            _loc1_ = window.findChildByName("slot_img_" + _loc3_) as IBitmapWrapperController;
            if(_loc1_ != null)
            {
               _loc1_.bitmap = _loc2_.clone();
               _loc1_.procedure = onSlotMouseEvent;
               _loc1_.mouseThreshold = 0;
            }
            _loc3_++;
         }
      }
      
      private function renderDucketCost() : void
      {
         if(window == null || recycler == null)
         {
            return;
         }
         var _loc1_:ITextWindow = window.findChildByName("ducket_cost") as ITextWindow;
         var _loc3_:IIconWindow = window.findChildByName("ducket_icon") as IIconWindow;
         var _loc2_:int = recycler.ducketCost;
         if(_loc2_ == 0)
         {
            _loc1_.visible = false;
            _loc3_.visible = false;
         }
         else
         {
            _loc1_.visible = true;
            _loc3_.visible = true;
            _loc1_.text = String(_loc2_);
         }
      }
      
      public function updateSlots() : void
      {
         var _loc4_:int = 0;
         var _loc3_:IBitmapWrapperController = null;
         var _loc2_:FurniSlotItem = null;
         var _loc1_:UnknownHabboRoom1 = null;
         if(window == null || recycler == null)
         {
            return;
         }
         _awaitingImages = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < recycler.numberOfSlots)
         {
            _loc3_ = window.findChildByName("slot_img_" + (_loc4_ + 1)) as IBitmapWrapperController;
            if(_loc3_ == null)
            {
               return;
            }
            _loc2_ = recycler.getSlotContent(_loc4_);
            if(_loc2_ == null)
            {
               _loc3_.bitmap = new BitmapData(1,1,true,16777215);
            }
            else
            {
               _loc1_ = getFurniImageResult(_loc2_);
               if(_loc1_ != null)
               {
                  if(_loc1_.data != null)
                  {
                     updateImage(_loc1_.data,_loc3_);
                  }
                  else
                  {
                     _awaitingImages[_loc1_.id] = _loc4_;
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function updateImage(param1:BitmapData, param2:IBitmapWrapperController) : void
      {
         var _loc4_:BitmapData = new BitmapData(param2.width,param2.height,true,16777215);
         _loc4_.fillRect(_loc4_.rect,16777215);
         var _loc3_:Point = new Point((param2.width - param1.width) / 2,(param2.height - param1.height) / 2);
         _loc4_.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         param2.bitmap = _loc4_;
         param1.dispose();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:IBitmapWrapperController = null;
         if(_awaitingImages != null && param1 in _awaitingImages)
         {
            _loc4_ = int(_awaitingImages[param1]);
            delete _awaitingImages[param1];
            _loc3_ = window.findChildByName("slot_img_" + (_loc4_ + 1)) as IBitmapWrapperController;
            if(_loc3_ == null)
            {
               return;
            }
            updateImage(param2,_loc3_);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
         if(_awaitingImages != null)
         {
            delete _awaitingImages[param1];
         }
      }
      
      private function getFurniImageResult(param1:FurniSlotItem) : UnknownHabboRoom1
      {
         if(param1 == null || page.viewer.roomEngine == null)
         {
            return null;
         }
         if(param1.category == 10)
         {
            return page.viewer.roomEngine.getFurnitureIcon(param1.typeId,this);
         }
         if(param1.category == 20)
         {
            return page.viewer.roomEngine.getWallItemIcon(param1.typeId,this,param1.xxxExtra);
         }
         return null;
      }
      
      private function get easterEggMode() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:FurniSlotItem = null;
         if(recycler == null)
         {
            return false;
         }
         _awaitingImages = new Dictionary();
         _loc2_ = 0;
         while(_loc2_ < recycler.numberOfSlots)
         {
            _loc1_ = recycler.getSlotContent(_loc2_);
            if(page.viewer.roomEngine.getFurnitureType(_loc1_.typeId) == "wf_act_reset_timers")
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function onMainContainerEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(page == null || page.viewer == null)
         {
            return;
         }
         var _loc5_:IRoomEngine = page.viewer.roomEngine;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:ISelectedRoomObjectData = _loc5_.getSelectedObjectData(_loc5_.activeRoomId);
         switch(param1.type)
         {
            case "WME_OUT":
               if(UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 != null)
               {
                  UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.onMainContainerEvent(param1,param2,_loc4_);
               }
               break;
            case "WME_MOVE":
               if(UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 != null)
               {
                  UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.onMainContainerEvent(param1,param2,_loc4_);
               }
               break;
            case "WME_OVER":
               if(UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 == null)
               {
                  UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 = new CatalogObjectMover();
                  UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.mainContainer = window;
                  UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.roomEngine = _loc5_;
               }
         }
         var _loc3_:Boolean = UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 != null && UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.state;
         if(_loc3_ && _loc5_.getObjectMoverIconSpriteVisible())
         {
            _loc5_.setObjectMoverIconSpriteVisible(false);
         }
      }
      
      private function onSlotMouseEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var objectData:ISelectedRoomObjectData;
         var slotId:int;
         var event:WindowEvent = param1;
         var target:IWindowModel = param2;
         var roomEngine:IRoomEngine = page.viewer.roomEngine;
         if(roomEngine == null || recycler == null)
         {
            return;
         }
         objectData = roomEngine.getSelectedObjectData(roomEngine.activeRoomId);
         if(event.type == "WME_UP")
         {
            if(event.window.name.indexOf("slot_") == 0)
            {
               slotId = int(event.window.name.charAt(event.window.name.length - 1)) - 1;
               if(objectData != null)
               {
                  if(objectData.operation != "OBJECT_PLACE")
                  {
                     page.viewer.catalog.windowManager.alert("${generic.alert.title}","${catalog.alert.recycler.inventory}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
                     {
                        param1.dispose();
                     });
                     return;
                  }
                  recycler.placeObjectAtSlot(slotId,objectData.id,objectData.category,objectData.typeId,objectData.instanceData);
               }
               else
               {
                  recycler.releaseSlot(slotId);
               }
               roomEngine.cancelRoomObjectInsert();
               if(UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1 != null)
               {
                  UnknownVarFromRecyclerCatalogWidget_CatalogObjectMover_1.resetIcon();
               }
               return;
            }
         }
         if(event.type == "WME_MOVE")
         {
            onMainContainerEvent(event,target);
         }
      }
      
      public function updateRecycleButton() : void
      {
         var _loc2_:int = 0;
         if(disposed || window == null)
         {
            return;
         }
         var _loc1_:IWindowModel = window.findChildByName("recycler_recycle");
         if(_loc1_ != null)
         {
            _loc2_ = recycler.secondsToWait();
            if(_loc2_ > 0)
            {
               _loc1_.caption = page.viewer.catalog.localization.getLocalizationWithParams("catalog.recycler.button.wait","","s",_loc2_);
            }
            else
            {
               _loc1_.caption = "${catalog.recycler.button.recycle}";
            }
            if(recycler.isReadyToRecycle() && !UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1.isBusy() && _loc2_ <= 0)
            {
               _loc1_.enable();
            }
            else
            {
               _loc1_.disable();
            }
            if(UnknownVarFromRecyclerCatalogWidget_Timer_1 == null && recycler.secondsToWait() > 0)
            {
               startTimer();
            }
         }
      }
      
      private function onRecycleButtonClick(param1:WindowMouseEvent) : void
      {
         var event:WindowMouseEvent = param1;
         if(!recycler.hasEnoughDuckets())
         {
            page.viewer.catalog.windowManager.alert("${generic.alert.title}","${catalog.alert.notenough.activitypoints.title.0}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
            return;
         }
         UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1.start(easterEggMode);
         updateRecycleButton();
         abortButtonVisible = true;
      }
      
      private function onAbortClick(param1:WindowMouseEvent) : void
      {
         abortButtonVisible = false;
         UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1.stop();
         updateRecycleButton();
         setTimeout(resetAnimation,650);
      }
      
      private function onAnimationComplete() : void
      {
         if(recycler != null)
         {
            recycler.executeRecycler();
            recycler.setNextRecycleAllowedTimestamp(getTimer() + recycler.timeout * 1000);
         }
         updateRecycleButton();
         setTimeout(resetAnimation,1000);
         abortButtonVisible = false;
      }
      
      private function resetAnimation() : void
      {
         UnknownVarFromRecyclerCatalogWidget_RecyclerEngineAnimator_1.reset();
      }
      
      private function set abortButtonVisible(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = window.findChildByName("abort_region");
         _loc2_.visible = param1;
      }
      
      private function get disabledBorder() : UnknownICoreWindowComponents6
      {
         return window.findChildByName("disabled_border") as UnknownICoreWindowComponents6;
      }
      
      private function get patFrankButton() : UnknownICoreWindowComponents4
      {
         return window.findChildByName("pat_frank_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get emoji1Bitmap() : IStaticBitmapWrapperWindow
      {
         return window.findChildByName("emoji_1") as IStaticBitmapWrapperWindow;
      }
      
      private function get emoji2BitmapTemplate() : IStaticBitmapWrapperWindow
      {
         return window.findChildByName("emoji_2_template") as IStaticBitmapWrapperWindow;
      }
   }
}

