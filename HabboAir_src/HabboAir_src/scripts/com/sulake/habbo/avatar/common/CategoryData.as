package com.sulake.habbo.avatar.common
{
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.inventory.IHabboInventory;
   
   public class CategoryData
   {
      private const MAX_PALETTES:int = 2;
      
      private var _parts:Array;
      
      private var _palettes:Array;
      
      private var _selectedPartIndex:int = -1;
      
      private var _paletteIndexes:Array;
      
      public function CategoryData(param1:Array, param2:Array)
      {
         super();
         _parts = param1;
         _palettes = param2;
         _paletteIndexes = [];
      }
      
      private static function defaultColorId(param1:Array, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:AvatarEditorGridColorItem = null;
         if(!param1 || param1.length == 0)
         {
            return -1;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_.partColor && _loc4_.partColor.clubLevel <= param2)
            {
               return _loc4_.partColor.id;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function dispose() : void
      {
         if(_parts)
         {
            for each(var _loc2_ in _parts)
            {
               _loc2_.dispose();
            }
            _parts = null;
         }
         if(_palettes)
         {
            for each(var _loc3_ in _palettes as Array)
            {
               if(_loc3_)
               {
                  for each(var _loc1_ in _loc3_)
                  {
                     _loc1_.dispose();
                  }
               }
            }
            _palettes = null;
         }
         _selectedPartIndex = -1;
         _paletteIndexes = null;
      }
      
      public function selectPartId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AvatarEditorGridPartItem = null;
         if(!_parts)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _parts.length)
         {
            _loc2_ = _parts[_loc3_];
            if(_loc2_.id == param1)
            {
               selectPartIndex(_loc3_);
               return;
            }
            _loc3_++;
         }
      }
      
      public function selectColorIds(param1:Array) : void
      {
         var _loc6_:AvatarEditorGridColorItem = null;
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:AvatarEditorGridColorItem = null;
         var _loc4_:int = 0;
         if(!_palettes)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         _paletteIndexes = new Array(param1.length);
         _loc7_ = 0;
         while(_loc7_ < _palettes.length)
         {
            _loc5_ = getPalette(_loc7_);
            if(_loc5_)
            {
               if(param1.length > _loc7_)
               {
                  _loc3_ = int(param1[_loc7_]);
               }
               else
               {
                  _loc2_ = _loc5_[0] as AvatarEditorGridColorItem;
                  if(_loc2_ && _loc2_.partColor)
                  {
                     _loc3_ = _loc2_.partColor.id;
                  }
               }
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  _loc6_ = _loc5_[_loc4_] as AvatarEditorGridColorItem;
                  if(_loc6_.partColor.id == _loc3_)
                  {
                     _paletteIndexes[_loc7_] = _loc4_;
                     _loc6_.isSelected = true;
                  }
                  else
                  {
                     _loc6_.isSelected = false;
                  }
                  _loc4_++;
               }
            }
            _loc7_++;
         }
         updatePartColors();
      }
      
      public function selectPartIndex(param1:int) : AvatarEditorGridPartItem
      {
         var _loc2_:AvatarEditorGridPartItem = null;
         var _loc3_:AvatarEditorGridPartItem = null;
         if(!_parts)
         {
            return null;
         }
         if(_selectedPartIndex >= 0 && _parts.length > _selectedPartIndex)
         {
            _loc2_ = _parts[_selectedPartIndex];
            if(_loc2_)
            {
               _loc2_.isSelected = false;
            }
         }
         if(_parts.length > param1)
         {
            _loc3_ = _parts[param1] as AvatarEditorGridPartItem;
            if(_loc3_)
            {
               _loc3_.isSelected = true;
               _selectedPartIndex = param1;
               return _loc3_;
            }
         }
         return null;
      }
      
      public function selectColorIndex(param1:int, param2:int) : AvatarEditorGridColorItem
      {
         var _loc4_:Array = getPalette(param2);
         if(!_loc4_)
         {
            return null;
         }
         if(_loc4_.length <= param1)
         {
            return null;
         }
         deselectColorIndex(_paletteIndexes[param2],param2);
         _paletteIndexes[param2] = param1;
         var _loc3_:AvatarEditorGridColorItem = _loc4_[param1] as AvatarEditorGridColorItem;
         if(!_loc3_)
         {
            return null;
         }
         _loc3_.isSelected = true;
         updatePartColors();
         return _loc3_;
      }
      
      public function getCurrentColorIndex(param1:int) : int
      {
         if(_paletteIndexes.length <= param1)
         {
            return 0;
         }
         return _paletteIndexes[param1];
      }
      
      private function deselectColorIndex(param1:int, param2:int) : void
      {
         var _loc4_:Array = getPalette(param2);
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.length <= param1)
         {
            return;
         }
         var _loc3_:AvatarEditorGridColorItem = _loc4_[param1] as AvatarEditorGridColorItem;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.isSelected = false;
      }
      
      public function getSelectedColorIds() : Array
      {
         var _loc8_:int = 0;
         var _loc7_:Array = null;
         var _loc5_:AvatarEditorGridColorItem = null;
         if(!_paletteIndexes || _paletteIndexes.length == 0)
         {
            return null;
         }
         if(!_palettes || _palettes.length == 0)
         {
            return null;
         }
         var _loc4_:Array = _palettes[0] as Array;
         if(!_loc4_ || _loc4_.length == 0)
         {
            return null;
         }
         var _loc3_:AvatarEditorGridColorItem = _loc4_[0] as AvatarEditorGridColorItem;
         if(!_loc3_ || !_loc3_.partColor)
         {
            return null;
         }
         var _loc1_:int = _loc3_.partColor.id;
         var _loc2_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _paletteIndexes.length)
         {
            _loc7_ = _palettes[_loc8_];
            if(!(!_loc7_ || _loc7_.length <= _loc8_))
            {
               if(_loc7_.length > _paletteIndexes[_loc8_])
               {
                  _loc5_ = _loc7_[_paletteIndexes[_loc8_]] as AvatarEditorGridColorItem;
                  if(_loc5_ && _loc5_.partColor)
                  {
                     _loc2_.push(_loc5_.partColor.id);
                  }
                  else
                  {
                     _loc2_.push(_loc1_);
                  }
               }
               else
               {
                  _loc2_.push(_loc1_);
               }
            }
            _loc8_++;
         }
         var _loc6_:AvatarEditorGridPartItem = getCurrentPart();
         if(!_loc6_)
         {
            return null;
         }
         return _loc2_.slice(0,Math.max(_loc6_.colorLayerCount,1));
      }
      
      private function getSelectedColors() : Array
      {
         var _loc3_:AvatarEditorGridColorItem = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _paletteIndexes.length)
         {
            _loc3_ = getSelectedColor(_loc2_);
            if(_loc3_)
            {
               _loc1_.push(_loc3_.partColor);
            }
            else
            {
               _loc1_.push(null);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getSelectedColor(param1:int) : AvatarEditorGridColorItem
      {
         var _loc2_:Array = getPalette(param1);
         if(!_loc2_ || _loc2_.length <= _paletteIndexes[param1])
         {
            return null;
         }
         return _loc2_[_paletteIndexes[param1]] as AvatarEditorGridColorItem;
      }
      
      public function getCurrentColorId(param1:int) : int
      {
         var _loc2_:AvatarEditorGridColorItem = getSelectedColor(param1);
         if(_loc2_ && _loc2_.partColor)
         {
            return _loc2_.partColor.id;
         }
         return 0;
      }
      
      public function get parts() : Array
      {
         return _parts;
      }
      
      public function getPalette(param1:int) : Array
      {
         if(!_paletteIndexes)
         {
            return null;
         }
         if(!_palettes)
         {
            return null;
         }
         if(_palettes.length <= param1)
         {
            return null;
         }
         return _palettes[param1] as Array;
      }
      
      public function getCurrentPart() : AvatarEditorGridPartItem
      {
         return _parts[_selectedPartIndex] as AvatarEditorGridPartItem;
      }
      
      private function updatePartColors() : void
      {
         var _loc2_:Array = getSelectedColors();
         for each(var _loc1_ in _parts)
         {
            if(_loc1_)
            {
               _loc1_.colors = _loc2_;
            }
         }
      }
      
      public function hasClubSelectionsOverLevel(param1:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc8_:IPartColor = null;
         var _loc2_:IFigurePartSet = null;
         var _loc5_:Boolean = false;
         var _loc7_:Array = getSelectedColors();
         if(_loc7_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc7_.length)
            {
               _loc8_ = _loc7_[_loc6_];
               if(_loc8_ != null && _loc8_.clubLevel > param1)
               {
                  _loc5_ = true;
               }
               _loc6_++;
            }
         }
         var _loc3_:Boolean = false;
         var _loc4_:AvatarEditorGridPartItem = getCurrentPart();
         if(_loc4_ != null && _loc4_.partSet)
         {
            _loc2_ = _loc4_.partSet;
            if(_loc2_ != null && _loc2_.clubLevel > param1)
            {
               _loc3_ = true;
            }
         }
         return _loc5_ || _loc3_;
      }
      
      public function hasInvalidSellableItems(param1:IHabboInventory) : Boolean
      {
         var _loc2_:IFigurePartSet = null;
         var _loc3_:Boolean = false;
         var _loc4_:AvatarEditorGridPartItem = getCurrentPart();
         if(_loc4_ != null && _loc4_.partSet)
         {
            _loc2_ = _loc4_.partSet;
            if(_loc2_ != null && _loc2_.isSellable && !param1.hasFigureSetIdInInventory(_loc2_.id))
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function stripClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc3_:IFigurePartSet = null;
         var _loc2_:AvatarEditorGridPartItem = null;
         var _loc4_:AvatarEditorGridPartItem = getCurrentPart();
         if(_loc4_ && _loc4_.partSet)
         {
            _loc3_ = _loc4_.partSet;
            if(_loc3_.clubLevel > param1)
            {
               _loc2_ = selectPartIndex(0);
               if(_loc2_ != null && _loc2_.partSet == null)
               {
                  selectPartIndex(1);
               }
               return true;
            }
         }
         return false;
      }
      
      public function stripClubColorsOverLevel(param1:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc8_:IPartColor = null;
         var _loc4_:Array = [];
         var _loc7_:Array = getSelectedColors();
         var _loc2_:Boolean = false;
         var _loc6_:Array = getPalette(0);
         var _loc3_:int = defaultColorId(_loc6_,param1);
         if(_loc3_ == -1)
         {
            return false;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc8_ = _loc7_[_loc5_];
            if(_loc8_ == null)
            {
               _loc4_.push(_loc3_);
               _loc2_ = true;
            }
            else if(_loc8_.clubLevel > param1)
            {
               _loc4_.push(_loc3_);
               _loc2_ = true;
            }
            else
            {
               _loc4_.push(_loc8_.id);
            }
            _loc5_++;
         }
         if(_loc2_)
         {
            selectColorIds(_loc4_);
         }
         return _loc2_;
      }
      
      public function stripInvalidSellableItems(param1:IHabboInventory) : Boolean
      {
         var _loc3_:IFigurePartSet = null;
         var _loc2_:AvatarEditorGridPartItem = null;
         var _loc4_:AvatarEditorGridPartItem = getCurrentPart();
         if(_loc4_ && _loc4_.partSet)
         {
            _loc3_ = _loc4_.partSet;
            if(_loc3_.isSellable && !param1.hasFigureSetIdInInventory(_loc3_.id))
            {
               _loc2_ = selectPartIndex(0);
               if(_loc2_ != null && _loc2_.partSet == null)
               {
                  selectPartIndex(1);
               }
               return true;
            }
         }
         return false;
      }
      
      public function get selectedPartIndex() : int
      {
         return _selectedPartIndex;
      }
   }
}

