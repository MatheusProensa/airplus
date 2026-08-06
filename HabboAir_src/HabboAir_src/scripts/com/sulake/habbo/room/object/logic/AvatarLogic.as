package com.sulake.habbo.room.object.logic
{
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectMoveEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarBlockedUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDirectionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarExpressionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGuideStatusUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarHabbiconUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarMutedUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarOwnMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayingGameMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.utils.getTimer;
   
   public class AvatarLogic extends MovingObjectLogic
   {
      private static const UnknownConstFromAvatarLogic_Number_1:Number = 1.5;
      
      private static const EFFECT_TYPE_SPLASH:int = 28;
      
      private static const EFFECT_TYPE_SWIM:int = 29;
      
      private static const UnknownConstFromAvatarLogic_Int_1:int = 184;
      
      private static const UnknownConstFromAvatarLogic_Int_2:int = 185;
      
      private static const EFFECT_SPLASH_LENGTH:int = 500;
      
      private static const CARRY_ITEM_NULL:int = 0;
      
      private static const CARRY_ITEM_LAST_CONSUMABLE:int = 999;
      
      private static const CARRY_ITEM_EMPTY_HAND:int = 999999999;
      
      private static const CARRY_ITEM_DELAY_BEFORE_USE:int = 5000;
      
      private static const CARRY_ITEM_EMPTY_HAND_ANIMATION_LENGTH:int = 1500;
      
      private static const SPINNING_DUCK_HABBICON_NAME:String = "duck_spinning";
      
      private static const HABBICON_SPIN_DURATION_MS:int = 3200;
      
      private static const HABBICON_SPIN_STEP_MS:int = 100;
      
      private static const HABBICON_SPIN_STEP_DEGREES:int = -45;
      
      private var _selected:Boolean = false;
      
      private var UnknownVarFromAvatarLogic_Vector3d_1:Vector3d = null;
      
      private var UnknownVarFromAvatarLogic_Int_1:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_2:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_3:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_4:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_5:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_6:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_7:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_8:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_9:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_10:int = 0;
      
      private var _allowUseCarryObject:Boolean = false;
      
      private var UnknownVarFromAvatarLogic_Int_11:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_12:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_13:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_14:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_15:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_16:int = 0;
      
      private var UnknownVarFromAvatarLogic_Int_17:int = 0;
      
      public function AvatarLogic()
      {
         super();
         UnknownVarFromAvatarLogic_Int_12 = getTimer() + getBlinkInterval();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROE_MOUSE_CLICK","ROME_POSITION_CHANGED","ROE_MOUSE_ENTER","ROE_MOUSE_LEAVE","ROFCAE_MOUSE_BUTTON","ROFCAE_MOUSE_ARROW"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(_selected && object != null)
         {
            if(eventDispatcher != null)
            {
               _loc1_ = new RoomObjectMoveEvent("ROME_OBJECT_REMOVED",object);
               eventDispatcher.dispatchEvent(_loc1_);
            }
         }
         super.dispose();
         UnknownVarFromAvatarLogic_Vector3d_1 = null;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc12_:RoomObjectAvatarPostureUpdateMessage = null;
         var _loc25_:RoomObjectAvatarChatUpdateMessage = null;
         var _loc30_:RoomObjectAvatarTypingUpdateMessage = null;
         var _loc13_:RoomObjectAvatarMutedUpdateMessage = null;
         var _loc2_:RoomObjectAvatarPlayingGameMessage = null;
         var _loc21_:RoomObjectAvatarUpdateMessage = null;
         var _loc31_:RoomObjectAvatarDirectionUpdateMessage = null;
         var _loc20_:RoomObjectAvatarGestureUpdateMessage = null;
         var _loc15_:RoomObjectAvatarDanceUpdateMessage = null;
         var _loc16_:RoomObjectAvatarSleepUpdateMessage = null;
         var _loc27_:RoomObjectAvatarPlayerValueUpdateMessage = null;
         var _loc26_:RoomObjectAvatarHabbiconUpdateMessage = null;
         var _loc14_:int = 0;
         var _loc4_:RoomObjectAvatarEffectUpdateMessage = null;
         var _loc29_:int = 0;
         var _loc11_:int = 0;
         var _loc28_:RoomObjectAvatarCarryObjectUpdateMessage = null;
         var _loc8_:RoomObjectAvatarUseObjectUpdateMessage = null;
         var _loc5_:RoomObjectAvatarSignUpdateMessage = null;
         var _loc23_:RoomObjectAvatarFlatControlUpdateMessage = null;
         var _loc24_:Number = NaN;
         var _loc18_:RoomObjectAvatarFigureUpdateMessage = null;
         var _loc19_:String = null;
         var _loc9_:String = null;
         var _loc6_:String = null;
         var _loc10_:RoomObjectAvatarBlockedUpdateMessage = null;
         var _loc7_:Boolean = false;
         var _loc22_:RoomObjectAvatarSelectedMessage = null;
         var _loc3_:RoomObjectAvatarGuideStatusUpdateMessage = null;
         if(param1 == null || object == null)
         {
            return;
         }
         super.processUpdateMessage(param1);
         var _loc17_:IRoomObjectModelController = object.getModelController();
         if(param1 is RoomObjectAvatarPostureUpdateMessage)
         {
            _loc12_ = param1 as RoomObjectAvatarPostureUpdateMessage;
            _loc17_.setString("figure_posture",_loc12_.postureType);
            _loc17_.setString("figure_posture_parameter",_loc12_.parameter);
            return;
         }
         if(param1 is RoomObjectAvatarChatUpdateMessage)
         {
            _loc25_ = param1 as RoomObjectAvatarChatUpdateMessage;
            _loc17_.setNumber("figure_talk",1);
            UnknownVarFromAvatarLogic_Int_3 = getTimer() + _loc25_.numberOfWords * 1000;
            return;
         }
         if(param1 is RoomObjectAvatarTypingUpdateMessage)
         {
            _loc30_ = param1 as RoomObjectAvatarTypingUpdateMessage;
            _loc17_.setNumber("figure_is_typing",Number(_loc30_.isTyping));
            return;
         }
         if(param1 is RoomObjectAvatarMutedUpdateMessage)
         {
            _loc13_ = param1 as RoomObjectAvatarMutedUpdateMessage;
            _loc17_.setNumber("figure_is_muted",Number(_loc13_.isMuted));
            return;
         }
         if(param1 is RoomObjectAvatarPlayingGameMessage)
         {
            _loc2_ = param1 as RoomObjectAvatarPlayingGameMessage;
            _loc17_.setNumber("figure_is_playing_game",Number(_loc2_.isPlayingGame));
            return;
         }
         if(param1 is RoomObjectAvatarUpdateMessage)
         {
            _loc21_ = param1 as RoomObjectAvatarUpdateMessage;
            _loc17_.setNumber("head_direction",_loc21_.dirHead);
            _loc17_.setNumber("figure_can_stand_up",Number(_loc21_.canStandUp));
            _loc17_.setNumber("figure_vertical_offset",_loc21_.baseY);
            if(!isNaN(_loc21_.jumpingPower))
            {
               _loc17_.setNumber("figure_jumping_power",_loc21_.jumpingPower);
            }
            return;
         }
         if(param1 is RoomObjectAvatarDirectionUpdateMessage)
         {
            _loc31_ = param1 as RoomObjectAvatarDirectionUpdateMessage;
            _loc17_.setNumber("head_direction",_loc31_.dirHead);
            return;
         }
         if(param1 is RoomObjectAvatarGestureUpdateMessage)
         {
            _loc20_ = param1 as RoomObjectAvatarGestureUpdateMessage;
            _loc17_.setNumber("figure_gesture",_loc20_.gesture);
            UnknownVarFromAvatarLogic_Int_7 = getTimer() + 3000;
            return;
         }
         if(param1 is RoomObjectAvatarExpressionUpdateMessage)
         {
            _loc17_.setNumber("figure_expression",RoomObjectAvatarExpressionUpdateMessage(param1).expressionType);
            UnknownVarFromAvatarLogic_Int_6 = AvatarAction.getExpressionTime(_loc17_.getNumber("figure_expression"));
            if(UnknownVarFromAvatarLogic_Int_6 > -1)
            {
               UnknownVarFromAvatarLogic_Int_6 += getTimer();
            }
            return;
         }
         if(param1 is RoomObjectAvatarDanceUpdateMessage)
         {
            _loc15_ = param1 as RoomObjectAvatarDanceUpdateMessage;
            _loc17_.setNumber("figure_dance",_loc15_.danceStyle);
            return;
         }
         if(param1 is RoomObjectAvatarSleepUpdateMessage)
         {
            _loc16_ = param1 as RoomObjectAvatarSleepUpdateMessage;
            _loc17_.setNumber("figure_sleep",Number(_loc16_.isSleeping));
            return;
         }
         if(param1 is RoomObjectAvatarPlayerValueUpdateMessage)
         {
            _loc27_ = param1 as RoomObjectAvatarPlayerValueUpdateMessage;
            _loc17_.setNumber("figure_number_value",_loc27_.value);
            UnknownVarFromAvatarLogic_Int_13 = getTimer() + 3000;
            return;
         }
         if(param1 is RoomObjectAvatarHabbiconUpdateMessage)
         {
            _loc26_ = param1 as RoomObjectAvatarHabbiconUpdateMessage;
            _loc14_ = getTimer();
            _loc17_.setNumber("figure_habbicon",_loc26_.habbiconId);
            _loc17_.setNumber("figure_habbicon_trigger_sequence",_loc14_);
            UnknownVarFromAvatarLogic_Int_14 = _loc14_ + 6000;
            updateHabbiconSpinForHabbicon(_loc26_.habbiconId,_loc14_,_loc17_);
            return;
         }
         if(param1 is RoomObjectAvatarEffectUpdateMessage)
         {
            _loc4_ = param1 as RoomObjectAvatarEffectUpdateMessage;
            _loc29_ = _loc4_.effect;
            _loc11_ = _loc4_.delayMilliSeconds;
            updateEffect(_loc29_,_loc11_,_loc17_);
            return;
         }
         if(param1 is RoomObjectAvatarCarryObjectUpdateMessage)
         {
            _loc28_ = param1 as RoomObjectAvatarCarryObjectUpdateMessage;
            _loc17_.setNumber("figure_carry_object",_loc28_.itemType);
            _loc17_.setNumber("figure_use_object",0);
            UnknownVarFromAvatarLogic_Int_9 = getTimer();
            if(_loc28_.itemType < 999999999)
            {
               UnknownVarFromAvatarLogic_Int_10 = 0;
               _allowUseCarryObject = _loc28_.itemType <= 999;
            }
            else
            {
               UnknownVarFromAvatarLogic_Int_10 = UnknownVarFromAvatarLogic_Int_9 + 1500;
               _allowUseCarryObject = false;
            }
            return;
         }
         if(param1 is RoomObjectAvatarUseObjectUpdateMessage)
         {
            _loc8_ = param1 as RoomObjectAvatarUseObjectUpdateMessage;
            _loc17_.setNumber("figure_use_object",_loc8_.itemType);
            return;
         }
         if(param1 is RoomObjectAvatarSignUpdateMessage)
         {
            _loc5_ = param1 as RoomObjectAvatarSignUpdateMessage;
            _loc17_.setNumber("figure_sign",_loc5_.signType);
            UnknownVarFromAvatarLogic_Int_8 = getTimer() + 5000;
            return;
         }
         if(param1 is RoomObjectAvatarFlatControlUpdateMessage)
         {
            _loc23_ = param1 as RoomObjectAvatarFlatControlUpdateMessage;
            _loc24_ = parseInt(_loc23_.rawData);
            if(_loc24_ == _loc24_ && _loc24_ >= 0 && _loc24_ <= 5)
            {
               _loc17_.setNumber("figure_flat_control",_loc24_);
            }
            else
            {
               _loc17_.setNumber("figure_flat_control",0);
            }
            return;
         }
         if(param1 is RoomObjectAvatarFigureUpdateMessage)
         {
            _loc18_ = param1 as RoomObjectAvatarFigureUpdateMessage;
            _loc19_ = _loc17_.getString("figure");
            _loc9_ = _loc18_.figure;
            _loc6_ = _loc18_.gender;
            if(_loc19_ != null && _loc19_.indexOf(".bds-") != -1)
            {
               _loc9_ += _loc19_.substr(_loc19_.indexOf(".bds-"));
            }
            _loc17_.setString("figure",_loc9_);
            _loc17_.setString("gender",_loc6_);
            return;
         }
         if(param1 is RoomObjectAvatarBlockedUpdateMessage)
         {
            _loc10_ = param1 as RoomObjectAvatarBlockedUpdateMessage;
            _loc7_ = _loc10_.isBlocked;
            _loc17_.setNumber("blocked",_loc7_ ? 1 : 0);
            return;
         }
         if(param1 is RoomObjectAvatarSelectedMessage)
         {
            _loc22_ = param1 as RoomObjectAvatarSelectedMessage;
            _selected = _loc22_.selected;
            UnknownVarFromAvatarLogic_Vector3d_1 = null;
            return;
         }
         if(param1 is RoomObjectAvatarGuideStatusUpdateMessage)
         {
            _loc3_ = param1 as RoomObjectAvatarGuideStatusUpdateMessage;
            _loc17_.setNumber("figure_guide_status",_loc3_.guideStatus);
            return;
         }
         if(param1 is RoomObjectAvatarOwnMessage)
         {
            _loc17_.setNumber("own_user",1);
            return;
         }
      }
      
      private function updateEffect(param1:int, param2:int, param3:IRoomObjectModelController) : void
      {
         if(param1 == 28)
         {
            UnknownVarFromAvatarLogic_Int_1 = getTimer() + 500;
            UnknownVarFromAvatarLogic_Int_2 = 29;
         }
         else if(param1 == 184)
         {
            UnknownVarFromAvatarLogic_Int_1 = getTimer() + 500;
            UnknownVarFromAvatarLogic_Int_2 = 185;
         }
         else if(param3.getNumber("figure_effect") == 29)
         {
            UnknownVarFromAvatarLogic_Int_1 = getTimer() + 500;
            UnknownVarFromAvatarLogic_Int_2 = param1;
            param1 = 28;
         }
         else if(param3.getNumber("figure_effect") == 185)
         {
            UnknownVarFromAvatarLogic_Int_1 = getTimer() + 500;
            UnknownVarFromAvatarLogic_Int_2 = param1;
            param1 = 184;
         }
         else
         {
            if(param2 != 0)
            {
               UnknownVarFromAvatarLogic_Int_1 = getTimer() + param2;
               UnknownVarFromAvatarLogic_Int_2 = param1;
               return;
            }
            UnknownVarFromAvatarLogic_Int_1 = 0;
         }
         param3.setNumber("figure_effect",param1);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc5_:RoomObjectEvent = null;
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModelController = object.getModelController();
         var _loc4_:String = null;
         switch(param1.type)
         {
            case "click":
               _loc4_ = "ROE_MOUSE_CLICK";
               break;
            case "rollOver":
               _loc4_ = "ROE_MOUSE_ENTER";
               if(_loc3_ != null)
               {
                  _loc3_.setNumber("figure_highlight",1);
               }
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_BUTTON",object));
               break;
            case "rollOut":
               if(_loc3_ != null)
               {
                  _loc3_.setNumber("figure_highlight",0);
               }
               _loc4_ = "ROE_MOUSE_LEAVE";
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent("ROFCAE_MOUSE_ARROW",object));
               break;
            case "mouseDown":
               if(object.getType() == "rentable_bot")
               {
                  _loc5_ = new RoomObjectMouseEvent("ROE_MOUSE_DOWN",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                  eventDispatcher.dispatchEvent(_loc5_);
               }
         }
         if(_loc4_ != null)
         {
            if(eventDispatcher != null)
            {
               _loc5_ = new RoomObjectMouseEvent(_loc4_,object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
               eventDispatcher.dispatchEvent(_loc5_);
            }
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:IVector3d = null;
         var _loc4_:RoomObjectEvent = null;
         var _loc3_:IRoomObjectModelController = null;
         super.update(param1);
         if(_selected && object != null)
         {
            if(eventDispatcher != null)
            {
               _loc2_ = object.getLocation();
               if(UnknownVarFromAvatarLogic_Vector3d_1 == null || UnknownVarFromAvatarLogic_Vector3d_1.x != _loc2_.x || UnknownVarFromAvatarLogic_Vector3d_1.y != _loc2_.y || UnknownVarFromAvatarLogic_Vector3d_1.z != _loc2_.z)
               {
                  if(UnknownVarFromAvatarLogic_Vector3d_1 == null)
                  {
                     UnknownVarFromAvatarLogic_Vector3d_1 = new Vector3d();
                  }
                  UnknownVarFromAvatarLogic_Vector3d_1.assign(_loc2_);
                  _loc4_ = new RoomObjectMoveEvent("ROME_POSITION_CHANGED",object);
                  eventDispatcher.dispatchEvent(_loc4_);
               }
            }
         }
         if(object != null)
         {
            _loc3_ = object.getModelController();
            if(_loc3_ != null)
            {
               updateActions(param1,_loc3_);
            }
         }
      }
      
      private function updateActions(param1:int, param2:IRoomObjectModelController) : void
      {
         if(UnknownVarFromAvatarLogic_Int_3 > 0)
         {
            if(param1 > UnknownVarFromAvatarLogic_Int_3)
            {
               param2.setNumber("figure_talk",0);
               UnknownVarFromAvatarLogic_Int_3 = 0;
               UnknownVarFromAvatarLogic_Int_5 = 0;
               UnknownVarFromAvatarLogic_Int_4 = 0;
            }
            else if(UnknownVarFromAvatarLogic_Int_4 == 0 && UnknownVarFromAvatarLogic_Int_5 == 0)
            {
               UnknownVarFromAvatarLogic_Int_5 = param1 + getTalkingPauseInterval();
               UnknownVarFromAvatarLogic_Int_4 = UnknownVarFromAvatarLogic_Int_5 + getTalkingPauseLength();
            }
            else if(UnknownVarFromAvatarLogic_Int_5 > 0 && param1 > UnknownVarFromAvatarLogic_Int_5)
            {
               param2.setNumber("figure_talk",0);
               UnknownVarFromAvatarLogic_Int_5 = 0;
            }
            else if(UnknownVarFromAvatarLogic_Int_4 > 0 && param1 > UnknownVarFromAvatarLogic_Int_4)
            {
               param2.setNumber("figure_talk",1);
               UnknownVarFromAvatarLogic_Int_4 = 0;
            }
         }
         if(UnknownVarFromAvatarLogic_Int_6 > 0 && param1 > UnknownVarFromAvatarLogic_Int_6)
         {
            param2.setNumber("figure_expression",0);
            UnknownVarFromAvatarLogic_Int_6 = 0;
         }
         if(UnknownVarFromAvatarLogic_Int_7 > 0 && param1 > UnknownVarFromAvatarLogic_Int_7)
         {
            param2.setNumber("figure_gesture",0);
            UnknownVarFromAvatarLogic_Int_7 = 0;
         }
         if(UnknownVarFromAvatarLogic_Int_8 > 0 && param1 > UnknownVarFromAvatarLogic_Int_8)
         {
            param2.setNumber("figure_sign",-1);
            UnknownVarFromAvatarLogic_Int_8 = 0;
         }
         if(UnknownVarFromAvatarLogic_Int_10 > 0)
         {
            if(param1 > UnknownVarFromAvatarLogic_Int_10)
            {
               param2.setNumber("figure_carry_object",0);
               param2.setNumber("figure_use_object",0);
               UnknownVarFromAvatarLogic_Int_9 = UnknownVarFromAvatarLogic_Int_10 = 0;
               _allowUseCarryObject = false;
            }
         }
         if(_allowUseCarryObject)
         {
            if(param1 - UnknownVarFromAvatarLogic_Int_9 > 5000)
            {
               if((param1 - UnknownVarFromAvatarLogic_Int_9) % 10000 < 1000)
               {
                  param2.setNumber("figure_use_object",1);
               }
               else
               {
                  param2.setNumber("figure_use_object",0);
               }
            }
         }
         if(param1 > UnknownVarFromAvatarLogic_Int_12)
         {
            param2.setNumber("figure_blink",1);
            UnknownVarFromAvatarLogic_Int_12 = param1 + getBlinkInterval();
            UnknownVarFromAvatarLogic_Int_11 = param1 + getBlinkLength();
         }
         if(UnknownVarFromAvatarLogic_Int_11 > 0 && param1 > UnknownVarFromAvatarLogic_Int_11)
         {
            param2.setNumber("figure_blink",0);
            UnknownVarFromAvatarLogic_Int_11 = 0;
         }
         if(UnknownVarFromAvatarLogic_Int_1 > 0 && param1 > UnknownVarFromAvatarLogic_Int_1)
         {
            param2.setNumber("figure_effect",UnknownVarFromAvatarLogic_Int_2);
            UnknownVarFromAvatarLogic_Int_1 = 0;
         }
         if(UnknownVarFromAvatarLogic_Int_13 > 0 && param1 > UnknownVarFromAvatarLogic_Int_13)
         {
            param2.setNumber("figure_number_value",0);
            UnknownVarFromAvatarLogic_Int_13 = 0;
         }
         if(UnknownVarFromAvatarLogic_Int_14 > 0 && param1 > UnknownVarFromAvatarLogic_Int_14)
         {
            param2.setNumber("figure_habbicon",0);
            param2.setNumber("figure_habbicon_trigger_sequence",0);
            clearHabbiconSpin(param2);
            UnknownVarFromAvatarLogic_Int_14 = 0;
         }
         updateHabbiconSpin(param1,param2);
      }
      
      private function updateHabbiconSpinForHabbicon(param1:int, param2:int, param3:IRoomObjectModelController) : void
      {
         if(HabbiconAssetManager.getHabbiconNameKey(param1) == "duck_spinning")
         {
            UnknownVarFromAvatarLogic_Int_15 = param2;
            UnknownVarFromAvatarLogic_Int_16 = param2 + 3200;
            setHabbiconSpinOffset(0,param3);
            return;
         }
         clearHabbiconSpin(param3);
      }
      
      private function updateHabbiconSpin(param1:int, param2:IRoomObjectModelController) : void
      {
         var _loc3_:int = 0;
         if(UnknownVarFromAvatarLogic_Int_16 <= 0)
         {
            return;
         }
         if(param1 >= UnknownVarFromAvatarLogic_Int_16)
         {
            clearHabbiconSpin(param2);
            return;
         }
         _loc3_ = int((param1 - UnknownVarFromAvatarLogic_Int_15) / 100) * -45 % 360;
         setHabbiconSpinOffset(_loc3_,param2);
      }
      
      private function setHabbiconSpinOffset(param1:int, param2:IRoomObjectModelController) : void
      {
         if(UnknownVarFromAvatarLogic_Int_17 != param1)
         {
            UnknownVarFromAvatarLogic_Int_17 = param1;
            param2.setNumber("figure_habbicon_spin_offset",param1);
         }
      }
      
      private function clearHabbiconSpin(param1:IRoomObjectModelController) : void
      {
         UnknownVarFromAvatarLogic_Int_15 = 0;
         UnknownVarFromAvatarLogic_Int_16 = 0;
         setHabbiconSpinOffset(0,param1);
      }
      
      private function getTalkingPauseInterval() : int
      {
         return 100 + Math.random() * 200;
      }
      
      private function getTalkingPauseLength() : int
      {
         return 75 + Math.random() * 75;
      }
      
      private function getBlinkInterval() : int
      {
         return 4500 + Math.random() * 1000;
      }
      
      private function getBlinkLength() : int
      {
         return 50 + Math.random() * 200;
      }
      
      override protected function getCurveStrength(param1:RoomObjectMoveUpdateMessage) : int
      {
         var _loc2_:RoomObjectAvatarUpdateMessage = null;
         if(param1 == null || object == null)
         {
            return super.getCurveStrength(param1);
         }
         if(param1 is RoomObjectAvatarUpdateMessage)
         {
            _loc2_ = param1 as RoomObjectAvatarUpdateMessage;
            return _loc2_.jumpingPower;
         }
         var _loc3_:IRoomObjectModelController = object.getModelController();
         if(_loc3_.hasNumber("figure_jumping_power"))
         {
            return _loc3_.getNumber("figure_jumping_power");
         }
         return super.getCurveStrength(param1);
      }
      
      private function targetIsWarping(param1:IVector3d) : Boolean
      {
         var _loc2_:IVector3d = object.getLocation();
         if(param1 == null)
         {
            return false;
         }
         if(_loc2_.x == 0 && _loc2_.y == 0)
         {
            return false;
         }
         if(Math.abs(_loc2_.x - param1.x) > 1.5 || Math.abs(_loc2_.y - param1.y) > 1.5)
         {
            return true;
         }
         return false;
      }
   }
}

