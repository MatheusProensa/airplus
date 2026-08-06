package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindowModel;
   
   public class WindowRectLimits implements IRectLimiter
   {
      private var _minWidth:int = -2147483648;
      
      private var _maxWidth:int = 2147483647;
      
      private var _minHeight:int = -2147483648;
      
      private var _maxHeight:int = 2147483647;
      
      private var UnknownVarFromWindowRectLimits_IWindowModel_1:IWindowModel;
      
      public function WindowRectLimits(param1:IWindowModel)
      {
         super();
         UnknownVarFromWindowRectLimits_IWindowModel_1 = param1;
      }
      
      public function get minWidth() : int
      {
         return _minWidth;
      }
      
      public function get maxWidth() : int
      {
         return _maxWidth;
      }
      
      public function get minHeight() : int
      {
         return _minHeight;
      }
      
      public function get maxHeight() : int
      {
         return _maxHeight;
      }
      
      public function set minWidth(param1:int) : void
      {
         _minWidth = param1;
         if(_minWidth > -2147483648 && !UnknownVarFromWindowRectLimits_IWindowModel_1.disposed && UnknownVarFromWindowRectLimits_IWindowModel_1.width < _minWidth)
         {
            UnknownVarFromWindowRectLimits_IWindowModel_1.width = _minWidth;
         }
      }
      
      public function set maxWidth(param1:int) : void
      {
         _maxWidth = param1;
         if(_maxWidth < 2147483647 && !UnknownVarFromWindowRectLimits_IWindowModel_1.disposed && UnknownVarFromWindowRectLimits_IWindowModel_1.width > _maxWidth)
         {
            UnknownVarFromWindowRectLimits_IWindowModel_1.width = _maxWidth;
         }
      }
      
      public function set minHeight(param1:int) : void
      {
         _minHeight = param1;
         if(_minHeight > -2147483648 && !UnknownVarFromWindowRectLimits_IWindowModel_1.disposed && UnknownVarFromWindowRectLimits_IWindowModel_1.height < _minHeight)
         {
            UnknownVarFromWindowRectLimits_IWindowModel_1.height = _minHeight;
         }
      }
      
      public function set maxHeight(param1:int) : void
      {
         _maxHeight = param1;
         if(_maxHeight < 2147483647 && !UnknownVarFromWindowRectLimits_IWindowModel_1.disposed && UnknownVarFromWindowRectLimits_IWindowModel_1.height > _maxHeight)
         {
            UnknownVarFromWindowRectLimits_IWindowModel_1.height = _maxHeight;
         }
      }
      
      public function get isEmpty() : Boolean
      {
         return _minWidth == -2147483648 && _maxWidth == 2147483647 && _minHeight == -2147483648 && _maxHeight == 2147483647;
      }
      
      public function setEmpty() : void
      {
         _minWidth = -2147483648;
         _maxWidth = 2147483647;
         _minHeight = -2147483648;
         _maxHeight = 2147483647;
      }
      
      public function limit() : void
      {
         if(!isEmpty && UnknownVarFromWindowRectLimits_IWindowModel_1)
         {
            if(UnknownVarFromWindowRectLimits_IWindowModel_1.width < _minWidth)
            {
               UnknownVarFromWindowRectLimits_IWindowModel_1.width = _minWidth;
            }
            else if(UnknownVarFromWindowRectLimits_IWindowModel_1.width > _maxWidth)
            {
               UnknownVarFromWindowRectLimits_IWindowModel_1.width = _maxWidth;
            }
            if(UnknownVarFromWindowRectLimits_IWindowModel_1.height < _minHeight)
            {
               UnknownVarFromWindowRectLimits_IWindowModel_1.height = _minHeight;
            }
            else if(UnknownVarFromWindowRectLimits_IWindowModel_1.height > _maxHeight)
            {
               UnknownVarFromWindowRectLimits_IWindowModel_1.height = _maxHeight;
            }
         }
      }
      
      public function assign(param1:int, param2:int, param3:int, param4:int) : void
      {
         _minWidth = param1;
         _maxWidth = param2;
         _minHeight = param3;
         _maxHeight = param4;
         limit();
      }
      
      public function clone(param1:IWindowModel) : WindowRectLimits
      {
         var _loc2_:WindowRectLimits = new WindowRectLimits(param1);
         _loc2_._minWidth = _minWidth;
         _loc2_._maxWidth = _maxWidth;
         _loc2_._minHeight = _minHeight;
         _loc2_._maxHeight = _maxHeight;
         return _loc2_;
      }
   }
}

