package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.IVector3d;
   
   [SecureSWF(rename="true")]
   public class GuildEditorData
   {
      private var _baseParts:Vector.<BadgePartData>;
      
      private var _layerParts:Vector.<BadgePartData>;
      
      private var _badgeColors:Vector.<GuildColorData>;
      
      private var _guildPrimaryColors:Vector.<GuildColorData>;
      
      private var _guildSecondaryColors:Vector.<GuildColorData>;
      
      public function GuildEditorData(param1:IMessageDataWrapper = null)
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _baseParts = new Vector.<BadgePartData>();
         _layerParts = new Vector.<BadgePartData>();
         _badgeColors = new Vector.<GuildColorData>();
         _guildPrimaryColors = new Vector.<GuildColorData>();
         _guildSecondaryColors = new Vector.<GuildColorData>();
         super();
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _baseParts.push(new BadgePartData(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _layerParts.push(new BadgePartData(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _badgeColors.push(new GuildColorData(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _guildPrimaryColors.push(new GuildColorData(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _guildSecondaryColors.push(new GuildColorData(param1));
            _loc3_++;
         }
      }
      
      public function get baseParts() : Vector.<BadgePartData>
      {
         return _baseParts;
      }
      
      public function get layerParts() : Vector.<BadgePartData>
      {
         return _layerParts;
      }
      
      public function get badgeColors() : Vector.<GuildColorData>
      {
         return _badgeColors;
      }
      
      public function get guildPrimaryColors() : Vector.<GuildColorData>
      {
         return _guildPrimaryColors;
      }
      
      public function get guildSecondaryColors() : Vector.<GuildColorData>
      {
         return _guildSecondaryColors;
      }
      
      public function findMatchingPrimaryColorId(param1:int) : int
      {
         if(param1 < 0 || _badgeColors.length <= 0 || _badgeColors.length < param1 || _guildPrimaryColors.length <= 0)
         {
            return 0;
         }
         return findClosestColor(_badgeColors[param1],_guildPrimaryColors);
      }
      
      public function findMatchingSecondaryColorId(param1:int) : int
      {
         if(param1 < 0 || _badgeColors.length <= 0 || _badgeColors.length < param1 || _guildSecondaryColors.length <= 0)
         {
            return 0;
         }
         return findClosestColor(_badgeColors[param1],_guildSecondaryColors);
      }
      
      private function findClosestColor(param1:GuildColorData, param2:Vector.<GuildColorData>) : int
      {
         var _loc8_:int = 0;
         var _loc5_:IVector3d = null;
         var _loc6_:Number = NaN;
         var _loc4_:IVector3d = ColorConverter.rgb2CieLab(param1.color);
         var _loc7_:* = 0;
         var _loc3_:* = 1.7976931348623157e+308;
         _loc8_ = 0;
         while(_loc8_ < param2.length)
         {
            _loc5_ = ColorConverter.rgb2CieLab(param2[_loc8_].color);
            _loc6_ = Math.pow(_loc4_.x - _loc5_.x,2) + Math.pow(_loc4_.y - _loc5_.y,2) + Math.pow(_loc4_.z - _loc5_.z,2);
            if(_loc6_ < _loc3_)
            {
               _loc3_ = _loc6_;
               _loc7_ = _loc8_;
            }
            _loc8_++;
         }
         return param2[_loc7_].id;
      }
   }
}

