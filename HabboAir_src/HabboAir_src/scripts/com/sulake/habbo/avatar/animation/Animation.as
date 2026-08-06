package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   
   public class Animation implements IAnimation
   {
      private static const UnknownConstFromAnimation_Array_1:Array = [];
      
      private var _id:String;
      
      private var _description:String;
      
      private var _frames:Array;
      
      private var _spriteData:Vector.<ISpriteDataContainer>;
      
      private var _avatarData:AvatarDataContainer;
      
      private var _directionData:DirectionDataContainer;
      
      private var UnknownVarFromAnimation_Array_1:Array;
      
      private var UnknownVarFromAnimation_Array_2:Array;
      
      private var _overriddenActions:Map;
      
      private var _overrideFrames:Map;
      
      private var _resetOnToggle:Boolean;
      
      public function Animation(param1:AvatarStructure, param2:XML)
      {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc3_:Array = null;
         _frames = [];
         super();
         _id = String(param2.@name);
         if(param2.hasOwnProperty("@desc"))
         {
            _description = String(param2.@desc);
         }
         else
         {
            _description = _id;
         }
         if(param2.hasOwnProperty("@resetOnToggle"))
         {
            _resetOnToggle = Boolean(param2.@resetOnToggle);
         }
         else
         {
            _resetOnToggle = false;
         }
         if(param2.hasOwnProperty("sprite"))
         {
            _spriteData = new Vector.<ISpriteDataContainer>();
            for each(var _loc6_ in param2.sprite)
            {
               _spriteData.push(new SpriteDataContainer(this as IAnimation,_loc6_));
            }
         }
         if(param2.hasOwnProperty("avatar"))
         {
            _avatarData = new AvatarDataContainer(param2.avatar[0]);
         }
         if(param2.hasOwnProperty("direction"))
         {
            _directionData = new DirectionDataContainer(param2.direction[0]);
         }
         if(param2.hasOwnProperty("remove"))
         {
            UnknownVarFromAnimation_Array_1 = [];
            for each(var _loc8_ in param2.remove)
            {
               UnknownVarFromAnimation_Array_1.push(String(_loc8_.@id));
            }
         }
         if(param2.hasOwnProperty("add"))
         {
            UnknownVarFromAnimation_Array_2 = [];
            for each(var _loc9_ in param2.add)
            {
               UnknownVarFromAnimation_Array_2.push(new AddDataContainer(_loc9_));
            }
         }
         if(param2.hasOwnProperty("override"))
         {
            _overrideFrames = new Map();
            _overriddenActions = new Map();
            for each(var _loc4_ in param2.override)
            {
               _loc5_ = _loc4_.@name;
               _loc7_ = _loc4_.@override;
               _overriddenActions.add(_loc7_,_loc5_);
               _loc3_ = [];
               parseFrames(_loc3_,_loc4_.frame,param1);
               _overrideFrames.add(_loc5_,_loc3_);
            }
         }
         parseFrames(_frames,param2.frame,param1);
      }
      
      private function parseFrames(param1:Array, param2:XMLList, param3:AvatarStructure) : void
      {
         var _loc5_:Array = null;
         var _loc10_:IActionDefinition = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:AnimationLayerData = null;
         var _loc8_:AnimationLayerData = null;
         for each(var _loc11_ in param2)
         {
            _loc6_ = 1;
            if(_loc11_.@repeats > 1)
            {
               _loc6_ = int(_loc11_.@repeats);
            }
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc5_ = [];
               for each(var _loc9_ in _loc11_.bodypart)
               {
                  _loc10_ = param3.getActionDefinition(String(_loc9_.@action));
                  _loc12_ = new AnimationLayerData(_loc9_,"bodypart",_loc10_);
                  _loc5_.push(_loc12_);
               }
               for each(var _loc7_ in _loc11_.fx)
               {
                  _loc10_ = param3.getActionDefinition(String(_loc7_.@action));
                  _loc8_ = new AnimationLayerData(_loc7_,"fx",_loc10_);
                  _loc5_.push(_loc8_);
                  if(_loc10_ != null)
                  {
                  }
               }
               param1.push(_loc5_);
               _loc4_++;
            }
         }
      }
      
      public function frameCount(param1:String = null) : int
      {
         var _loc2_:Array = null;
         if(!param1)
         {
            return _frames.length;
         }
         if(_overrideFrames)
         {
            _loc2_ = _overrideFrames.getValue(param1);
            if(_loc2_)
            {
               return _loc2_.length;
            }
         }
         return 0;
      }
      
      public function hasOverriddenActions() : Boolean
      {
         if(!_overriddenActions)
         {
            return false;
         }
         return _overriddenActions.length > 0;
      }
      
      public function overriddenActionNames() : Array
      {
         if(!_overriddenActions)
         {
            return null;
         }
         return _overriddenActions.getKeys();
      }
      
      public function overridingAction(param1:String) : String
      {
         if(!_overriddenActions)
         {
            return null;
         }
         return _overriddenActions.getValue(param1);
      }
      
      private function getFrame(param1:int, param2:String = null) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Array = [];
         if(!param2)
         {
            if(_frames.length > 0)
            {
               _loc4_ = _frames[param1 % _frames.length];
            }
         }
         else
         {
            _loc3_ = _overrideFrames.getValue(param2) as Array;
            if(_loc3_ && _loc3_.length > 0)
            {
               _loc4_ = _loc3_[param1 % _loc3_.length];
            }
         }
         return _loc4_;
      }
      
      public function getAnimatedBodyPartIds(param1:int, param2:String = null) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_ in getFrame(param1,param2))
         {
            if(_loc3_.type == "bodypart")
            {
               _loc4_.push(_loc3_.id);
            }
            else if(_loc3_.type == "fx")
            {
               if(UnknownVarFromAnimation_Array_2)
               {
                  for each(var _loc5_ in UnknownVarFromAnimation_Array_2)
                  {
                     if(_loc5_.id == _loc3_.id)
                     {
                        _loc4_.push(_loc5_.align);
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getLayerData(param1:int, param2:String, param3:String = null) : AnimationLayerData
      {
         for each(var _loc4_ in getFrame(param1,param3))
         {
            if(_loc4_.id == param2)
            {
               return _loc4_ as AnimationLayerData;
            }
            if(_loc4_.type == "fx")
            {
               for each(var _loc5_ in UnknownVarFromAnimation_Array_2)
               {
                  if(_loc5_.align == param2 && _loc5_.id == _loc4_.id)
                  {
                     return _loc4_ as AnimationLayerData;
                  }
               }
            }
         }
         return null;
      }
      
      public function hasAvatarData() : Boolean
      {
         return _avatarData != null;
      }
      
      public function hasDirectionData() : Boolean
      {
         return _directionData != null;
      }
      
      public function hasAddData() : Boolean
      {
         return UnknownVarFromAnimation_Array_2 != null;
      }
      
      public function getAddData(param1:String) : AddDataContainer
      {
         if(UnknownVarFromAnimation_Array_2)
         {
            for each(var _loc2_ in UnknownVarFromAnimation_Array_2)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get spriteData() : Vector.<ISpriteDataContainer>
      {
         return _spriteData;
      }
      
      public function get avatarData() : AvatarDataContainer
      {
         return _avatarData;
      }
      
      public function get directionData() : DirectionDataContainer
      {
         return _directionData;
      }
      
      public function get removeData() : Array
      {
         return !!UnknownVarFromAnimation_Array_1 ? UnknownVarFromAnimation_Array_1 : UnknownConstFromAnimation_Array_1;
      }
      
      public function get addData() : Array
      {
         return !!UnknownVarFromAnimation_Array_2 ? UnknownVarFromAnimation_Array_2 : UnknownConstFromAnimation_Array_1;
      }
      
      public function toString() : String
      {
         return _description;
      }
      
      public function get resetOnToggle() : Boolean
      {
         return _resetOnToggle;
      }
   }
}

