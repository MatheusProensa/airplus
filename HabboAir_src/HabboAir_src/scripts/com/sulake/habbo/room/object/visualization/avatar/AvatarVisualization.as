package com.sulake.habbo.room.object.visualization.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImage_1;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.room.object.visualization.avatar.additions.FloatingIdleZ;
   import com.sulake.habbo.room.object.visualization.avatar.additions.GameClickTarget;
   import com.sulake.habbo.room.object.visualization.avatar.additions.GuideStatusBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.HabbiconBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.IGameClickTarget;
   import com.sulake.habbo.room.object.visualization.avatar.additions.MutedBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.NumberBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.TypingBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.UnknownHabboRoomObjectVisualizationAvatarAdditions1;
   import com.sulake.habbo.utils.BitmapHelper;
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AvatarVisualization extends RoomObjectSpriteVisualization implements UnknownIHabboAvatar1, IAvatarImage_1
   {
      private static const AVATAR_SPRITE_TAG:String = "avatar";
      
      private static const AVATAR_SPRITE_DEFAULT_DEPTH:Number = -0.01;
      
      private static const AVATAR_OWN_DEPTH_ADJUST:Number = 0.001;
      
      private static const AVATAR_SPRITE_LAYING_DEPTH:Number = -0.409;
      
      private static const BASE_Y_SCALE:int = 1000;
      
      private static const ANIMATION_FRAME_UPDATE_INTERVAL:int = 2;
      
      private static const SNOWBOARDING_EFFECT:int = 97;
      
      private static const FREEZE_EFFECT:int = 218;
      
      private static const MAX_AVATARS_WITH_EFFECT:int = 3;
      
      private static const SPRITE_INDEX_AVATAR:int = 0;
      
      private static const UnknownConstFromAvatarVisualization_Int_1:int = 1;
      
      private static const INITIAL_RESERVED_SPRITES:int = 2;
      
      private static const ADDITION_ID_IDLE_BUBBLE:int = 1;
      
      private static const ADDITION_ID_TYPING_BUBBLE:int = 2;
      
      private static const ADDITION_ID_EXPRESSION:int = 3;
      
      private static const ADDITION_ID_NUMBER_BUBBLE:int = 4;
      
      private static const ADDITION_ID_GAME_CLICK_TARGET:int = 5;
      
      private static const ADDITION_ID_MUTED_BUBBLE:int = 6;
      
      private static const ADDITION_ID_GUIDE_STATUS_BUBBLE:int = 7;
      
      private static const ADDITION_ID_HABBICON_BUBBLE:int = 8;
      
      private static const DEFAULT_CANVAS_OFFSETS:Array = [0,0,0];
      
      private static const VARIABLE_HOLDER_FILTER:Array = [new ColorMatrixFilter([0.9,0,0,0,0,0,1,0,0,40,0,0,1,0,80,0,0,0,0.85,0]),new GlowFilter(12318714,1,4,4,4,1,true,false)];
      
      private var _lastAnimationUpdateTime:int = -1000;
      
      private const UnknownConstFromAvatarVisualization_Int_2:int = 41;
      
      private var UnknownVarFromAvatarVisualization_AvatarVisualizationData_1:AvatarVisualizationData = null;
      
      private var _avatars:Map;
      
      private var UnknownVarFromAvatarVisualization_Map_1:Map;
      
      private var _updatesUntilFrameUpdate:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Boolean_1:Boolean;
      
      private var UnknownVarFromAvatarVisualization_String_1:String;
      
      private var UnknownVarFromAvatarVisualization_String_2:String;
      
      private var _forcedAnimFrames:int = 0;
      
      private var UnknownVarFromAvatarVisualization_BitmapDataAsset_1:BitmapDataAsset;
      
      private var _forceUpdate:Boolean;
      
      private var UnknownVarFromAvatarVisualization_Int_1:int;
      
      private var _headAngle:int = -1;
      
      private var _angle:int = -1;
      
      private var UnknownVarFromAvatarVisualization_Int_2:int = -1;
      
      private var UnknownVarFromAvatarVisualization_Int_3:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_4:int = 2;
      
      private var UnknownVarFromAvatarVisualization_Map_2:Map;
      
      private var UnknownVarFromAvatarVisualization_Int_5:int = -1;
      
      private var _posture:String = "";
      
      private var UnknownVarFromAvatarVisualization_String_3:String = "";
      
      private var UnknownVarFromAvatarVisualization_Boolean_2:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Boolean_3:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Boolean_4:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Int_6:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_7:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_8:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_9:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Boolean_5:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Boolean_6:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Int_10:int = -1;
      
      private var UnknownVarFromAvatarVisualization_Boolean_7:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Int_11:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_12:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_13:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_14:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Int_15:int = 0;
      
      private var UnknownVarFromAvatarVisualization_Boolean_8:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Boolean_9:Boolean = false;
      
      private var _layInside:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_IAvatarImage_2_1:IAvatarImage_2 = null;
      
      private var UnknownVarFromAvatarVisualization_Boolean_10:Boolean = false;
      
      private var UnknownVarFromAvatarVisualization_Number_1:Number = 1;
      
      private var _disposed:Boolean;
      
      public function AvatarVisualization()
      {
         super();
         _avatars = new Map();
         UnknownVarFromAvatarVisualization_Map_1 = new Map();
         UnknownVarFromAvatarVisualization_Boolean_1 = false;
         UnknownVarFromAvatarVisualization_Int_1 = Math.random() * 200 + 200;
      }
      
      private static function resolveHabbiconFacingDirection(param1:int) : int
      {
         param1 = (param1 % 8 + 8) % 8;
         if(param1 <= 2)
         {
            return 1;
         }
         if(param1 >= 4 && param1 <= 6)
         {
            return -1;
         }
         return 0;
      }
      
      private static function normalizeDirectionAngle(param1:int) : int
      {
         return (param1 % 360 + 360) % 360;
      }
      
      override public function dispose() : void
      {
         if(_avatars != null)
         {
            resetImages();
            _avatars.dispose();
            UnknownVarFromAvatarVisualization_Map_1.dispose();
            _avatars = null;
         }
         UnknownVarFromAvatarVisualization_AvatarVisualizationData_1 = null;
         UnknownVarFromAvatarVisualization_BitmapDataAsset_1 = null;
         if(UnknownVarFromAvatarVisualization_Map_2)
         {
            for each(var _loc1_ in UnknownVarFromAvatarVisualization_Map_2)
            {
               _loc1_.dispose();
            }
            UnknownVarFromAvatarVisualization_Map_2 = null;
         }
         super.dispose();
         _disposed = true;
      }
      
      override public function getSpriteList() : Array
      {
         var _loc17_:RoomObjectSpriteData = null;
         var _loc6_:RoomObjectSpriteData = null;
         var _loc11_:IAnimationLayerData = null;
         var _loc18_:int = 0;
         var _loc1_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc19_:* = 0;
         var _loc8_:int = 0;
         var _loc7_:String = null;
         var _loc2_:BitmapDataAsset = null;
         var _loc12_:Rectangle = null;
         var _loc5_:String = null;
         if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1 == null)
         {
            return null;
         }
         var _loc3_:IRoomObjectSprite = getSprite(1);
         if(_loc3_)
         {
            _loc17_ = new RoomObjectSpriteData();
            _loc17_.alpha = _loc3_.alpha;
            _loc17_.x = _loc3_.offsetX;
            _loc17_.y = _loc3_.offsetY;
            _loc17_.name = _loc3_.assetName;
            _loc17_.width = _loc3_.width;
            _loc17_.height = _loc3_.height;
         }
         var _loc9_:Array = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getServerRenderData();
         for each(var _loc10_ in UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getSprites())
         {
            _loc6_ = new RoomObjectSpriteData();
            _loc11_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getLayerData(_loc10_);
            _loc18_ = 0;
            _loc1_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getDirection();
            _loc13_ = _loc10_.getDirectionOffsetX(_loc1_);
            _loc14_ = _loc10_.getDirectionOffsetY(_loc1_);
            _loc15_ = _loc10_.getDirectionOffsetZ(_loc1_);
            _loc19_ = 0;
            if(_loc10_.hasDirections)
            {
               _loc19_ = _loc1_;
            }
            if(_loc11_ != null)
            {
               _loc18_ = _loc11_.animationFrame;
               _loc13_ += _loc11_.dx;
               _loc14_ += _loc11_.dy;
               _loc19_ += _loc11_.directionOffset;
            }
            _loc8_ = 64;
            if(_loc8_ < 48)
            {
               _loc13_ /= 2;
               _loc14_ /= 2;
            }
            if(_loc19_ < 0)
            {
               _loc19_ += 8;
            }
            else if(_loc19_ > 7)
            {
               _loc19_ -= 8;
            }
            _loc7_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getScale() + "_" + _loc10_.member + "_" + _loc19_ + "_" + _loc18_;
            _loc2_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getAsset(_loc7_);
            if(_loc2_ != null)
            {
               _loc6_.x = -_loc2_.offset.x - _loc8_ / 2 + _loc13_;
               _loc6_.y = -_loc2_.offset.y + _loc14_;
               if(_loc10_.hasStaticY)
               {
                  _loc6_.y += UnknownVarFromAvatarVisualization_Int_15 * _loc8_ / (2 * 1000);
               }
               if(_loc10_.ink == 33)
               {
                  _loc6_.blendMode = "add";
               }
               _loc6_.name = _loc7_;
               if(UnknownVarFromAvatarVisualization_Boolean_9)
               {
                  _loc6_.z = -0.409 - 0.001 * spriteCount * _loc15_;
               }
               else
               {
                  _loc6_.z = -0.001 * spriteCount * _loc15_;
               }
               _loc12_ = _loc2_.rectangle;
               if(_loc12_ == null)
               {
                  _loc6_.width = 60;
                  _loc6_.height = 60;
               }
               else
               {
                  _loc6_.width = _loc12_.width;
                  _loc6_.height = _loc12_.height;
               }
               _loc9_.push(_loc6_);
            }
         }
         var _loc4_:IAvatarDataContainer = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.avatarSpriteData;
         if(_loc4_ != null && _loc4_.paletteIsGrayscale)
         {
            _loc5_ = _loc4_.reds[0].toString();
            for each(var _loc16_ in _loc9_)
            {
               if(_loc16_.name.indexOf("h_std_fx") == -1 && _loc16_.name.indexOf("h_std_sd") == -1)
               {
                  _loc16_.color = _loc5_;
               }
            }
         }
         if(_loc17_)
         {
            _loc9_.push(_loc17_);
         }
         return _loc9_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get angle() : int
      {
         return _angle;
      }
      
      public function get habbiconFacingDirection() : int
      {
         if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1 == null)
         {
            return 0;
         }
         return resolveHabbiconFacingDirection(UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getDirection());
      }
      
      public function get posture() : String
      {
         return _posture;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         UnknownVarFromAvatarVisualization_AvatarVisualizationData_1 = param1 as AvatarVisualizationData;
         createSprites(2);
         return true;
      }
      
      private function updateModel(param1:IRoomObjectModel, param2:Number, param3:Boolean) : Boolean
      {
         var _loc8_:Boolean = false;
         var _loc4_:* = false;
         var _loc9_:int = 0;
         var _loc6_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:IGameClickTarget = null;
         var _loc7_:int = 0;
         var _loc5_:String = null;
         if(param1.getUpdateID() != UnknownVarFromRoomObjectSpriteVisualization_Int_3)
         {
            _loc8_ = false;
            _loc4_ = false;
            _loc9_ = 0;
            _loc6_ = "";
            _loc4_ = param1.getNumber("figure_talk") > 0 && param3;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_2)
            {
               UnknownVarFromAvatarVisualization_Boolean_2 = _loc4_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_expression");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_6)
            {
               UnknownVarFromAvatarVisualization_Int_6 = _loc9_;
               _loc8_ = true;
            }
            _loc4_ = param1.getNumber("figure_sleep") > 0;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_3)
            {
               UnknownVarFromAvatarVisualization_Boolean_3 = _loc4_;
               _loc8_ = true;
            }
            _loc4_ = param1.getNumber("figure_blink") > 0 && param3;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_4)
            {
               UnknownVarFromAvatarVisualization_Boolean_4 = _loc4_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_gesture");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_7)
            {
               UnknownVarFromAvatarVisualization_Int_7 = _loc9_;
               _loc8_ = true;
            }
            _loc6_ = param1.getString("figure_posture");
            if(_loc6_ != _posture)
            {
               _posture = _loc6_;
               _loc8_ = true;
            }
            _loc6_ = param1.getString("figure_posture_parameter");
            if(_loc6_ != UnknownVarFromAvatarVisualization_String_3)
            {
               UnknownVarFromAvatarVisualization_String_3 = _loc6_;
               _loc8_ = true;
            }
            _loc4_ = param1.getNumber("figure_can_stand_up") > 0;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_8)
            {
               UnknownVarFromAvatarVisualization_Boolean_8 = _loc4_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_vertical_offset") * 1000;
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_15)
            {
               UnknownVarFromAvatarVisualization_Int_15 = _loc9_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_dance");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_8)
            {
               UnknownVarFromAvatarVisualization_Int_8 = _loc9_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_effect");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_11)
            {
               UnknownVarFromAvatarVisualization_Int_11 = _loc9_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_carry_object");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_12)
            {
               UnknownVarFromAvatarVisualization_Int_12 = _loc9_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_use_object");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_13)
            {
               UnknownVarFromAvatarVisualization_Int_13 = _loc9_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("head_direction");
            if(_loc9_ != _headAngle)
            {
               _headAngle = _loc9_;
               _loc8_ = true;
            }
            _loc10_ = param1.getNumber("figure_alpha_multiplier");
            if(isNaN(_loc10_))
            {
               _loc10_ = 1;
            }
            if(_loc10_ != UnknownVarFromAvatarVisualization_Number_1)
            {
               UnknownVarFromAvatarVisualization_Number_1 = _loc10_;
               _loc8_ = true;
            }
            if(UnknownVarFromAvatarVisualization_Int_12 > 0 && param1.getNumber("figure_use_object") > 0)
            {
               if(UnknownVarFromAvatarVisualization_Int_13 != UnknownVarFromAvatarVisualization_Int_12)
               {
                  UnknownVarFromAvatarVisualization_Int_13 = UnknownVarFromAvatarVisualization_Int_12;
                  _loc8_ = true;
               }
            }
            else if(UnknownVarFromAvatarVisualization_Int_13 != 0)
            {
               UnknownVarFromAvatarVisualization_Int_13 = 0;
               _loc8_ = true;
            }
            _loc11_ = getAddition(1) as FloatingIdleZ;
            if(UnknownVarFromAvatarVisualization_Boolean_3)
            {
               if(!_loc11_)
               {
                  _loc11_ = addAddition(new FloatingIdleZ(1,this));
               }
               _loc8_ = true;
            }
            else if(_loc11_)
            {
               removeAddition(1);
            }
            _loc4_ = param1.getNumber("figure_is_muted") > 0;
            _loc11_ = getAddition(6) as MutedBubble;
            if(_loc4_)
            {
               if(!_loc11_)
               {
                  _loc11_ = addAddition(new MutedBubble(6,this));
               }
               removeAddition(2);
               _loc8_ = true;
            }
            else
            {
               if(_loc11_)
               {
                  removeAddition(6);
                  _loc8_ = true;
               }
               _loc4_ = param1.getNumber("figure_is_typing") > 0;
               _loc11_ = getAddition(2) as TypingBubble;
               if(_loc4_)
               {
                  if(!_loc11_)
                  {
                     _loc11_ = addAddition(new TypingBubble(2,this));
                  }
                  _loc8_ = true;
               }
               else if(_loc11_)
               {
                  removeAddition(2);
               }
            }
            _loc9_ = param1.getNumber("figure_guide_status");
            if(_loc9_ != 0)
            {
               removeAddition(7);
               addAddition(new GuideStatusBubble(7,this,_loc9_));
               _loc8_ = true;
            }
            else if(getAddition(7) as GuideStatusBubble != null)
            {
               removeAddition(7);
               _loc8_ = true;
            }
            _loc4_ = param1.getNumber("figure_is_playing_game") > 0;
            _loc11_ = getAddition(5) as GameClickTarget;
            if(_loc4_)
            {
               if(!_loc11_)
               {
                  _loc11_ = addAddition(new GameClickTarget(5));
               }
               _loc8_ = true;
            }
            else if(_loc11_)
            {
               removeAddition(5);
            }
            _loc9_ = param1.getNumber("figure_number_value");
            _loc11_ = getAddition(4) as NumberBubble;
            if(_loc9_ > 0)
            {
               if(!_loc11_)
               {
                  _loc11_ = addAddition(new NumberBubble(4,_loc9_,this));
               }
               _loc8_ = true;
            }
            else if(_loc11_)
            {
               removeAddition(4);
            }
            _loc9_ = param1.getNumber("figure_habbicon");
            _loc7_ = param1.getNumber("figure_habbicon_trigger_sequence");
            _loc11_ = getAddition(8) as HabbiconBubble;
            if(_loc9_ > 0)
            {
               if(!_loc11_ || HabbiconBubble(_loc11_).habbiconId != _loc9_ || HabbiconBubble(_loc11_).triggerSequence != _loc7_)
               {
                  removeAddition(8);
                  _loc11_ = addAddition(new HabbiconBubble(8,_loc9_,_loc7_,this));
               }
               _loc8_ = true;
            }
            else if(_loc11_)
            {
               removeAddition(8);
            }
            _loc9_ = param1.getNumber("figure_habbicon_spin_offset");
            if(_loc9_ != UnknownVarFromAvatarVisualization_Int_3)
            {
               UnknownVarFromAvatarVisualization_Int_3 = _loc9_;
               _loc8_ = true;
            }
            _loc9_ = param1.getNumber("figure_expression");
            _loc11_ = getAddition(3);
            if(_loc9_ > 0)
            {
               if(!_loc11_)
               {
                  _loc11_ = UnknownHabboRoomObjectVisualizationAvatarAdditions1.make(3,_loc9_,this);
                  if(_loc11_)
                  {
                     addAddition(_loc11_);
                  }
               }
            }
            else if(_loc11_)
            {
               removeAddition(3);
            }
            validateActions(param2);
            _loc6_ = param1.getString("gender");
            if(_loc6_ != UnknownVarFromAvatarVisualization_String_2)
            {
               UnknownVarFromAvatarVisualization_String_2 = _loc6_;
               _loc8_ = true;
            }
            _loc5_ = param1.getString("figure");
            if(updateFigure(_loc5_))
            {
               _loc8_ = true;
            }
            if(param1.hasNumber("figure_sign"))
            {
               _loc9_ = param1.getNumber("figure_sign");
               if(_loc9_ != UnknownVarFromAvatarVisualization_Int_10)
               {
                  _loc8_ = true;
                  UnknownVarFromAvatarVisualization_Int_10 = _loc9_;
               }
            }
            if(param1.hasNumber("blocked"))
            {
               _loc4_ = param1.getNumber("blocked") > 0;
               if(updateBlocked(_loc4_))
               {
                  _loc8_ = true;
               }
            }
            _loc4_ = param1.getNumber("figure_highlight_enable") > 0;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_5)
            {
               UnknownVarFromAvatarVisualization_Boolean_5 = _loc4_;
               _loc8_ = true;
            }
            if(UnknownVarFromAvatarVisualization_Boolean_5)
            {
               _loc9_ = param1.getNumber("figure_highlight");
               if(_loc9_ != UnknownVarFromAvatarVisualization_Int_9)
               {
                  UnknownVarFromAvatarVisualization_Int_9 = _loc9_;
                  _loc8_ = true;
               }
            }
            _loc4_ = param1.getNumber("figure_highlight_variable_holder") > 0;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_6)
            {
               UnknownVarFromAvatarVisualization_Boolean_6 = _loc4_;
               _loc8_ = true;
            }
            _loc4_ = param1.getNumber("own_user") > 0;
            if(_loc4_ != UnknownVarFromAvatarVisualization_Boolean_10)
            {
               UnknownVarFromAvatarVisualization_Boolean_10 = _loc4_;
               _loc8_ = true;
            }
            UnknownVarFromRoomObjectSpriteVisualization_Int_3 = param1.getUpdateID();
            return _loc8_;
         }
         return false;
      }
      
      private function updateFigure(param1:String) : Boolean
      {
         if(UnknownVarFromAvatarVisualization_String_1 != param1)
         {
            UnknownVarFromAvatarVisualization_String_1 = param1;
            resetImages();
            return true;
         }
         return false;
      }
      
      private function updateBlocked(param1:Boolean) : Boolean
      {
         if(UnknownVarFromAvatarVisualization_Boolean_7 != param1)
         {
            UnknownVarFromAvatarVisualization_Boolean_7 = param1;
            resetImages();
            return true;
         }
         return false;
      }
      
      private function resetImages() : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in _avatars)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
         for each(_loc2_ in UnknownVarFromAvatarVisualization_Map_1)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
         _avatars.reset();
         UnknownVarFromAvatarVisualization_Map_1.reset();
         UnknownVarFromAvatarVisualization_IAvatarImage_2_1 = null;
         var _loc1_:IRoomObjectSprite = getSprite(0);
         if(_loc1_ != null)
         {
            _loc1_.asset = null;
            _loc1_.alpha = 255;
         }
      }
      
      private function validateActions(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 < 48)
         {
            UnknownVarFromAvatarVisualization_Boolean_4 = false;
         }
         if(_posture == "sit" || _posture == "lay")
         {
            UnknownVarFromAvatarVisualization_Int_14 = param1 / 2;
         }
         else
         {
            UnknownVarFromAvatarVisualization_Int_14 = 0;
         }
         _layInside = false;
         UnknownVarFromAvatarVisualization_Boolean_9 = false;
         if(_posture == "lay")
         {
            UnknownVarFromAvatarVisualization_Boolean_9 = true;
            _loc2_ = int(UnknownVarFromAvatarVisualization_String_3);
            if(_loc2_ < 0)
            {
               _layInside = true;
            }
         }
      }
      
      private function getAvatarImage(param1:Number, param2:int) : IAvatarImage_2
      {
         var _loc4_:IAvatarImage_2 = null;
         var _loc5_:IAvatarImage_2 = null;
         var _loc3_:String = "avatarImage" + param1.toString();
         if(param2 == 0)
         {
            _loc4_ = _avatars.getValue(_loc3_) as IAvatarImage_2;
         }
         else
         {
            _loc3_ += "-" + param2;
            _loc4_ = UnknownVarFromAvatarVisualization_Map_1.getValue(_loc3_) as IAvatarImage_2;
            if(_loc4_)
            {
               _loc4_.forceActionUpdate();
            }
         }
         if(_loc4_ == null)
         {
            _loc4_ = UnknownVarFromAvatarVisualization_AvatarVisualizationData_1.getAvatar(UnknownVarFromAvatarVisualization_String_1,param1,UnknownVarFromAvatarVisualization_String_2,this,this,UnknownVarFromAvatarVisualization_Boolean_7);
            if(_loc4_ != null)
            {
               if(param2 == 0)
               {
                  _avatars.add(_loc3_,_loc4_);
               }
               else
               {
                  if(UnknownVarFromAvatarVisualization_Map_1.length >= 3)
                  {
                     _loc5_ = UnknownVarFromAvatarVisualization_Map_1.remove(UnknownVarFromAvatarVisualization_Map_1.getKey(0));
                     if(_loc5_)
                     {
                        _loc5_.dispose();
                     }
                  }
                  UnknownVarFromAvatarVisualization_Map_1.add(_loc3_,_loc4_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getAvatarRendererAsset(param1:String) : ISoundAsset
      {
         return !!UnknownVarFromAvatarVisualization_AvatarVisualizationData_1 ? UnknownVarFromAvatarVisualization_AvatarVisualizationData_1.getAvatarRendererAsset(param1) : null;
      }
      
      private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean, param4:Boolean = false) : Boolean
      {
         var _loc6_:* = false;
         var _loc5_:int = 0;
         var _loc7_:* = 0;
         if(param4 || UnknownVarFromRoomObjectSpriteVisualization_Int_2 != param1.getUpdateID() || UnknownVarFromAvatarVisualization_Int_5 != param2.updateId)
         {
            _loc6_ = param3;
            _loc5_ = param1.getDirection().x - param2.direction.x;
            _loc5_ = (_loc5_ % 360 + 360) % 360;
            if(_posture == "sit" && UnknownVarFromAvatarVisualization_Boolean_8)
            {
               _loc5_ -= _loc5_ % 90 - 45;
            }
            _loc7_ = _headAngle;
            if(_posture == "float")
            {
               _loc7_ = _loc5_;
            }
            else
            {
               _loc7_ -= param2.direction.x;
            }
            _loc7_ = (_loc7_ % 360 + 360) % 360;
            if(_posture == "sit" && UnknownVarFromAvatarVisualization_Boolean_8 || _posture == "swdieback" || _posture == "swdiefront")
            {
               _loc7_ -= _loc7_ % 90 - 45;
            }
            if(UnknownVarFromAvatarVisualization_Int_3 != 0)
            {
               _loc5_ = normalizeDirectionAngle(_loc5_ + UnknownVarFromAvatarVisualization_Int_3);
               _loc7_ = normalizeDirectionAngle(_loc7_ + UnknownVarFromAvatarVisualization_Int_3);
            }
            if(_loc5_ != _angle || param4)
            {
               _loc6_ = true;
               _angle = _loc5_;
               _loc5_ -= 112.5;
               _loc5_ = (_loc5_ + 360) % 360;
               UnknownVarFromAvatarVisualization_IAvatarImage_2_1.setDirectionAngle("full",_loc5_);
            }
            if(_loc7_ != UnknownVarFromAvatarVisualization_Int_2 || param4)
            {
               _loc6_ = true;
               UnknownVarFromAvatarVisualization_Int_2 = _loc7_;
               if(UnknownVarFromAvatarVisualization_Int_2 != _angle)
               {
                  _loc7_ -= 112.5;
                  _loc7_ = (_loc7_ + 360) % 360;
                  UnknownVarFromAvatarVisualization_IAvatarImage_2_1.setDirectionAngle("head",_loc7_);
               }
            }
            UnknownVarFromRoomObjectSpriteVisualization_Int_2 = param1.getUpdateID();
            UnknownVarFromAvatarVisualization_Int_5 = param2.updateId;
            return _loc6_;
         }
         return false;
      }
      
      private function updateShadow(param1:Number, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:IRoomObjectSprite = getSprite(1);
         UnknownVarFromAvatarVisualization_BitmapDataAsset_1 = null;
         var _loc5_:Boolean = _posture == "mv" || _posture == "std" || _posture == "sit" && UnknownVarFromAvatarVisualization_Boolean_8;
         if(UnknownVarFromAvatarVisualization_Int_11 == 97 || UnknownVarFromAvatarVisualization_Int_11 == 218)
         {
            _loc5_ = false;
         }
         if(_loc5_)
         {
            _loc6_.visible = true;
            if(UnknownVarFromAvatarVisualization_BitmapDataAsset_1 == null || param1 != UnknownVarFromRoomObjectSpriteVisualization_Int_4 || param2)
            {
               _loc3_ = 0;
               _loc4_ = 0;
               if(param1 < 48)
               {
                  _loc6_.libraryAssetName = "sh_std_sd_1_0_0";
                  UnknownVarFromAvatarVisualization_BitmapDataAsset_1 = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getAsset(_loc6_.libraryAssetName);
                  _loc3_ = -8;
                  _loc4_ = UnknownVarFromAvatarVisualization_Boolean_8 ? 6 : -3;
               }
               else
               {
                  _loc6_.libraryAssetName = "h_std_sd_1_0_0";
                  UnknownVarFromAvatarVisualization_BitmapDataAsset_1 = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getAsset(_loc6_.libraryAssetName);
                  _loc3_ = -17;
                  _loc4_ = UnknownVarFromAvatarVisualization_Boolean_8 ? 10 : -7;
               }
               if(UnknownVarFromAvatarVisualization_BitmapDataAsset_1 != null)
               {
                  _loc6_.asset = UnknownVarFromAvatarVisualization_BitmapDataAsset_1.content as BitmapData;
                  _loc6_.offsetX = _loc3_;
                  _loc6_.offsetY = _loc4_;
                  _loc6_.alpha = 50 * UnknownVarFromAvatarVisualization_Number_1;
                  _loc6_.relativeDepth = 1;
               }
               else
               {
                  _loc6_.visible = false;
               }
            }
         }
         else
         {
            UnknownVarFromAvatarVisualization_BitmapDataAsset_1 = null;
            _loc6_.visible = false;
         }
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc10_:IRoomObjectSprite = null;
         var _loc22_:IRoomObjectSprite = null;
         var _loc18_:Array = null;
         var _loc26_:BitmapData = null;
         var _loc36_:BitmapFilter = null;
         var _loc33_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:IAnimationLayerData = null;
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc16_:IAnimationLayerData = null;
         var _loc43_:int = 0;
         var _loc17_:int = 0;
         var _loc19_:int = 0;
         var _loc21_:int = 0;
         var _loc25_:* = 0;
         var _loc30_:String = null;
         var _loc6_:BitmapDataAsset = null;
         var _loc31_:int = 0;
         var _loc8_:Boolean = false;
         var _loc38_:int = 0;
         var _loc37_:int = 0;
         var _loc39_:IRoomObject = object;
         if(_loc39_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromAvatarVisualization_AvatarVisualizationData_1 == null)
         {
            return;
         }
         if(--UnknownVarFromAvatarVisualization_Int_1 <= 0 && UnknownVarFromAvatarVisualization_IAvatarImage_2_1)
         {
            UnknownVarFromAvatarVisualization_IAvatarImage_2_1.disposeInactiveActionCache();
            UnknownVarFromAvatarVisualization_Int_1 = 500;
         }
         var _loc15_:* = param2 >= _lastAnimationUpdateTime + 41;
         if(_loc15_)
         {
            _lastAnimationUpdateTime += 41;
            if(_lastAnimationUpdateTime + 41 < param2)
            {
               _lastAnimationUpdateTime = param2 - 41;
            }
         }
         var _loc23_:IRoomObjectModel = _loc39_.getModel();
         var _loc11_:Number = param1.scale;
         var _loc7_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc35_:int = UnknownVarFromAvatarVisualization_Int_11;
         var _loc42_:Boolean = false;
         var _loc34_:Number = UnknownVarFromAvatarVisualization_Number_1;
         var _loc40_:Boolean = false;
         var _loc32_:Boolean = updateModel(_loc23_,_loc11_,param3);
         if(_forceUpdate)
         {
            resetImages();
            _forceUpdate = false;
         }
         if(_loc32_ || _loc11_ != UnknownVarFromRoomObjectSpriteVisualization_Int_4 || UnknownVarFromAvatarVisualization_IAvatarImage_2_1 == null)
         {
            if(_loc11_ != UnknownVarFromRoomObjectSpriteVisualization_Int_4)
            {
               _loc20_ = true;
               validateActions(_loc11_);
            }
            if(_loc35_ != UnknownVarFromAvatarVisualization_Int_11)
            {
               _loc42_ = true;
            }
            if(_loc34_ != UnknownVarFromAvatarVisualization_Number_1)
            {
               _loc40_ = true;
            }
            if(_loc20_ || UnknownVarFromAvatarVisualization_IAvatarImage_2_1 == null || _loc42_ || _loc40_)
            {
               UnknownVarFromAvatarVisualization_IAvatarImage_2_1 = getAvatarImage(_loc11_,UnknownVarFromAvatarVisualization_Int_11);
               if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1 == null)
               {
                  return;
               }
               _loc7_ = true;
               _loc10_ = getSprite(0);
               if(_loc10_)
               {
                  if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1 && (UnknownVarFromAvatarVisualization_IAvatarImage_2_1.isPlaceholder() || UnknownVarFromAvatarVisualization_IAvatarImage_2_1.isBlocked()))
                  {
                     _loc10_.alpha = 150 * _loc34_;
                     if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1.isBlocked())
                     {
                        _loc10_.color = 6710886;
                     }
                     else
                     {
                        _loc10_.color = 16777215;
                     }
                  }
                  else
                  {
                     _loc10_.alpha = 255;
                     _loc10_.color = 16777215;
                  }
               }
            }
            if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1 == null)
            {
               return;
            }
            if(_loc42_ && UnknownVarFromAvatarVisualization_IAvatarImage_2_1.animationHasResetOnToggle)
            {
               UnknownVarFromAvatarVisualization_IAvatarImage_2_1.resetAnimationFrameCounter();
            }
            updateShadow(_loc11_,_loc40_);
            _loc9_ = updateObject(_loc39_,param1,param3,true);
            updateActions(UnknownVarFromAvatarVisualization_IAvatarImage_2_1);
            if(UnknownVarFromAvatarVisualization_Map_2)
            {
               _loc5_ = UnknownVarFromAvatarVisualization_Int_4;
               for each(var _loc24_ in UnknownVarFromAvatarVisualization_Map_2)
               {
                  _loc24_.update(getSprite(_loc5_++),_loc11_);
               }
            }
            UnknownVarFromRoomObjectSpriteVisualization_Int_4 = _loc11_;
         }
         else
         {
            _loc9_ = updateObject(_loc39_,param1,param3);
         }
         if(_loc15_ && UnknownVarFromAvatarVisualization_Map_2)
         {
            _loc5_ = UnknownVarFromAvatarVisualization_Int_4;
            for each(_loc24_ in UnknownVarFromAvatarVisualization_Map_2)
            {
               if(_loc24_.animate(getSprite(_loc5_++)))
               {
                  increaseUpdateId();
               }
            }
         }
         var _loc41_:Boolean = _loc9_ || _loc32_ || _loc20_;
         var _loc29_:Boolean = (UnknownVarFromAvatarVisualization_Boolean_1 || _forcedAnimFrames > 0) && param3 && _loc15_;
         if(_loc41_)
         {
            _forcedAnimFrames = 2;
         }
         if(_loc41_ || _loc29_)
         {
            increaseUpdateId();
            if(_loc15_)
            {
               _forcedAnimFrames--;
               _updatesUntilFrameUpdate--;
            }
            if(!(_updatesUntilFrameUpdate <= 0 || _loc20_ || _loc32_ || _loc7_))
            {
               return;
            }
            UnknownVarFromAvatarVisualization_IAvatarImage_2_1.updateAnimationByFrames(1);
            _updatesUntilFrameUpdate = 2;
            _loc18_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getCanvasOffsets();
            if(_loc18_ == null || _loc18_.length < 3)
            {
               _loc18_ = DEFAULT_CANVAS_OFFSETS;
            }
            _loc22_ = getSprite(0);
            if(_loc22_ != null)
            {
               _loc26_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getImage("full",UnknownVarFromAvatarVisualization_Int_9 || UnknownVarFromAvatarVisualization_Boolean_6);
               if(_loc26_ != null)
               {
                  if(UnknownVarFromAvatarVisualization_Int_9)
                  {
                     _loc36_ = new GlowFilter(16777215,1,6,6);
                     _loc26_.applyFilter(_loc26_,_loc26_.rect,new Point(0,0),_loc36_);
                  }
                  else if(UnknownVarFromAvatarVisualization_Boolean_6)
                  {
                     for each(_loc36_ in VARIABLE_HOLDER_FILTER)
                     {
                        _loc26_.applyFilter(_loc26_,_loc26_.rect,new Point(0,0),_loc36_);
                     }
                  }
                  _loc22_.asset = _loc26_;
               }
               if(_loc22_.asset)
               {
                  _loc22_.offsetX = -1 * _loc11_ / 2 + _loc18_[0] - (_loc22_.asset.width - _loc11_) / 2;
                  _loc22_.offsetY = -_loc22_.asset.height + _loc11_ / 4 + _loc18_[1] + UnknownVarFromAvatarVisualization_Int_14;
                  if(_posture == "swdieback" || _posture == "swdiefront")
                  {
                     _loc22_.offsetY += 20 * _loc11_ / 32;
                  }
               }
               if(UnknownVarFromAvatarVisualization_Boolean_9)
               {
                  if(_layInside)
                  {
                     _loc22_.relativeDepth = -0.5;
                  }
                  else
                  {
                     _loc22_.relativeDepth = -0.409 + _loc18_[2];
                  }
               }
               else
               {
                  _loc22_.relativeDepth = -0.01 + _loc18_[2];
               }
               if(UnknownVarFromAvatarVisualization_Boolean_10)
               {
                  _loc22_.relativeDepth -= 0.001;
                  _loc22_.spriteType = RoomObjectSpriteType.UnknownVarFromRoomObjectSpriteType_Int_1;
               }
               else
               {
                  _loc22_.spriteType = RoomObjectSpriteType.AVATAR;
               }
               _loc22_.alpha = 255 * _loc34_;
            }
            _loc24_ = getAddition(2) as TypingBubble;
            if(_loc24_)
            {
               if(!UnknownVarFromAvatarVisualization_Boolean_9)
               {
                  TypingBubble(_loc24_).relativeDepth = -0.01 - 0.01 + _loc18_[2];
               }
               else
               {
                  TypingBubble(_loc24_).relativeDepth = -0.409 - 0.01 + _loc18_[2];
               }
            }
            UnknownVarFromAvatarVisualization_Boolean_1 = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.isAnimating();
            _loc33_ = 2;
            _loc27_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getDirection();
            for each(var _loc14_ in UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getSprites())
            {
               if(_loc14_.id == "avatar")
               {
                  _loc22_ = getSprite(0);
                  _loc28_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getLayerData(_loc14_);
                  _loc13_ = _loc14_.getDirectionOffsetX(_loc27_);
                  _loc12_ = _loc14_.getDirectionOffsetY(_loc27_);
                  if(_loc28_ != null)
                  {
                     _loc13_ += _loc28_.dx;
                     _loc12_ += _loc28_.dy;
                  }
                  if(_loc11_ < 48)
                  {
                     _loc13_ /= 2;
                     _loc12_ /= 2;
                  }
                  if(!UnknownVarFromAvatarVisualization_Boolean_8)
                  {
                     _loc22_.offsetX += _loc13_;
                     _loc22_.offsetY += _loc12_;
                  }
               }
               else
               {
                  _loc22_ = getSprite(_loc33_);
                  if(_loc22_ != null)
                  {
                     _loc22_.alphaTolerance = 256;
                     _loc22_.visible = true;
                     _loc16_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getLayerData(_loc14_);
                     _loc43_ = 0;
                     _loc17_ = _loc14_.getDirectionOffsetX(_loc27_);
                     _loc19_ = _loc14_.getDirectionOffsetY(_loc27_);
                     _loc21_ = _loc14_.getDirectionOffsetZ(_loc27_);
                     _loc25_ = 0;
                     if(_loc14_.hasDirections)
                     {
                        _loc25_ = _loc27_;
                     }
                     if(_loc16_ != null)
                     {
                        _loc43_ = _loc16_.animationFrame;
                        _loc17_ += _loc16_.dx;
                        _loc19_ += _loc16_.dy;
                        _loc25_ += _loc16_.directionOffset;
                     }
                     if(_loc11_ < 48)
                     {
                        _loc17_ /= 2;
                        _loc19_ /= 2;
                     }
                     if(_loc25_ < 0)
                     {
                        _loc25_ += 8;
                     }
                     else if(_loc25_ > 7)
                     {
                        _loc25_ -= 8;
                     }
                     _loc30_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getScale() + "_" + _loc14_.member + "_" + _loc25_ + "_" + _loc43_;
                     _loc6_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getAsset(_loc30_);
                     _loc31_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getScale() == "sh" ? 32 : 64;
                     _loc8_ = false;
                     if(_loc6_ == null)
                     {
                        if(UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getScale() == "sh")
                        {
                           _loc30_ = "h_" + _loc14_.member + "_" + _loc25_ + "_" + _loc43_;
                           _loc6_ = UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getAsset(_loc30_);
                           _loc8_ = true;
                        }
                        if(_loc6_ == null)
                        {
                           continue;
                        }
                     }
                     _loc22_.asset = _loc8_ ? BitmapHelper.resampleBitmapData(_loc6_.content as BitmapData,0.5) : _loc6_.content as BitmapData;
                     _loc38_ = _loc8_ ? _loc6_.offset.x / 2 : _loc6_.offset.x;
                     _loc37_ = _loc8_ ? _loc6_.offset.y / 2 : _loc6_.offset.y;
                     _loc22_.offsetX = -_loc38_ - _loc31_ / 2 + _loc17_;
                     _loc22_.offsetY = -_loc37_ + _loc19_;
                     if(_loc14_.hasStaticY)
                     {
                        _loc22_.offsetY += UnknownVarFromAvatarVisualization_Int_15 * _loc11_ / (2 * 1000);
                     }
                     else
                     {
                        _loc22_.offsetY += UnknownVarFromAvatarVisualization_Int_14;
                     }
                     if(UnknownVarFromAvatarVisualization_Boolean_9)
                     {
                        _loc22_.relativeDepth = -0.409 - 0.001 * spriteCount * _loc21_;
                     }
                     else
                     {
                        _loc22_.relativeDepth = -0.01 - 0.001 * spriteCount * _loc21_;
                     }
                     if(_loc14_.ink == 33)
                     {
                        _loc22_.blendMode = "add";
                     }
                     else
                     {
                        _loc22_.blendMode = "normal";
                     }
                  }
                  _loc33_++;
               }
            }
         }
      }
      
      private function updateActions(param1:IAvatarImage_2) : void
      {
         var _loc3_:String = null;
         var _loc5_:IRoomObjectSprite = null;
         if(param1 == null)
         {
            return;
         }
         param1.initActionAppends();
         param1.appendAction("posture",_posture,UnknownVarFromAvatarVisualization_String_3);
         if(UnknownVarFromAvatarVisualization_Int_7 > 0)
         {
            param1.appendAction("gest",AvatarAction.getGesture(UnknownVarFromAvatarVisualization_Int_7));
         }
         if(UnknownVarFromAvatarVisualization_Int_8 > 0)
         {
            param1.appendAction("dance",UnknownVarFromAvatarVisualization_Int_8);
         }
         if(UnknownVarFromAvatarVisualization_Int_10 > -1)
         {
            param1.appendAction("sign",UnknownVarFromAvatarVisualization_Int_10);
         }
         if(UnknownVarFromAvatarVisualization_Int_12 > 0)
         {
            param1.appendAction("cri",UnknownVarFromAvatarVisualization_Int_12);
         }
         if(UnknownVarFromAvatarVisualization_Int_13 > 0)
         {
            param1.appendAction("usei",UnknownVarFromAvatarVisualization_Int_13);
         }
         if(UnknownVarFromAvatarVisualization_Boolean_2)
         {
            param1.appendAction("talk");
         }
         if(UnknownVarFromAvatarVisualization_Boolean_3 || UnknownVarFromAvatarVisualization_Boolean_4)
         {
            param1.appendAction("Sleep");
         }
         if(UnknownVarFromAvatarVisualization_Int_6 > 0)
         {
            _loc3_ = AvatarAction.getExpression(UnknownVarFromAvatarVisualization_Int_6);
            if(_loc3_ != "")
            {
               switch(_loc3_)
               {
                  case "dance":
                     param1.appendAction("dance",2);
                     break;
                  case "67":
                     param1.appendAction("dance","sixseven");
                     break;
                  default:
                     param1.appendAction(_loc3_);
               }
            }
         }
         if(UnknownVarFromAvatarVisualization_Int_11 > 0)
         {
            param1.appendAction("fx",UnknownVarFromAvatarVisualization_Int_11);
         }
         param1.endActionAppends();
         UnknownVarFromAvatarVisualization_Boolean_1 = param1.isAnimating();
         var _loc2_:int = 2;
         for each(var _loc4_ in UnknownVarFromAvatarVisualization_IAvatarImage_2_1.getSprites())
         {
            if(_loc4_.id != "avatar")
            {
               _loc2_++;
            }
         }
         if(_loc2_ != spriteCount)
         {
            createSprites(_loc2_);
         }
         UnknownVarFromAvatarVisualization_Int_4 = _loc2_;
         if(UnknownVarFromAvatarVisualization_Map_2)
         {
            for each(var _loc6_ in UnknownVarFromAvatarVisualization_Map_2)
            {
               _loc5_ = addSprite();
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         _forceUpdate = true;
      }
      
      public function avatarEffectReady(param1:int) : void
      {
         _forceUpdate = true;
      }
      
      protected function get numAdditions() : int
      {
         return !!UnknownVarFromAvatarVisualization_Map_2 ? UnknownVarFromAvatarVisualization_Map_2.length : 0;
      }
      
      public function addAddition(param1:IGameClickTarget) : IGameClickTarget
      {
         if(!UnknownVarFromAvatarVisualization_Map_2)
         {
            UnknownVarFromAvatarVisualization_Map_2 = new Map();
         }
         if(UnknownVarFromAvatarVisualization_Map_2.hasKey(param1.id))
         {
            throw new Error("Avatar addition with index " + param1.id + "already exists!");
         }
         UnknownVarFromAvatarVisualization_Map_2.add(param1.id,param1);
         return param1;
      }
      
      public function getAddition(param1:int) : IGameClickTarget
      {
         return !!UnknownVarFromAvatarVisualization_Map_2 ? UnknownVarFromAvatarVisualization_Map_2[param1] : null;
      }
      
      public function removeAddition(param1:int) : void
      {
         var _loc2_:IGameClickTarget = getAddition(param1);
         if(!_loc2_)
         {
            return;
         }
         UnknownVarFromAvatarVisualization_Map_2.remove(param1);
         _loc2_.dispose();
      }
   }
}

