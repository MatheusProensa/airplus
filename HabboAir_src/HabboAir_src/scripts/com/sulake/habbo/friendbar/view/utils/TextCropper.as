package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.ITextWindow;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextCropper implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromTextCropper_TextField_1:TextField;
      
      private var UnknownVarFromTextCropper_TextFormat_1:TextFormat;
      
      private var UnknownVarFromTextCropper_String_1:String = "...";
      
      private var UnknownVarFromTextCropper_Int_1:int = 20;
      
      public function TextCropper()
      {
         super();
         UnknownVarFromTextCropper_TextField_1 = new TextField();
         UnknownVarFromTextCropper_TextField_1.autoSize = "left";
         UnknownVarFromTextCropper_TextField_1.antiAliasType = "advanced";
         UnknownVarFromTextCropper_TextField_1.gridFitType = "pixel";
         UnknownVarFromTextCropper_TextFormat_1 = UnknownVarFromTextCropper_TextField_1.defaultTextFormat;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromTextCropper_TextField_1 = null;
            _disposed = true;
         }
      }
      
      public function crop(param1:ITextWindow) : void
      {
         var _loc2_:int = 0;
         UnknownVarFromTextCropper_TextFormat_1.font = param1.fontFace;
         UnknownVarFromTextCropper_TextFormat_1.size = param1.fontSize;
         UnknownVarFromTextCropper_TextFormat_1.bold = param1.bold;
         UnknownVarFromTextCropper_TextFormat_1.italic = param1.italic;
         UnknownVarFromTextCropper_TextField_1.setTextFormat(UnknownVarFromTextCropper_TextFormat_1);
         UnknownVarFromTextCropper_TextField_1.text = param1.getLineText(0);
         var _loc3_:int = UnknownVarFromTextCropper_TextField_1.textWidth;
         if(_loc3_ > param1.width)
         {
            _loc2_ = UnknownVarFromTextCropper_TextField_1.getCharIndexAtPoint(param1.width - UnknownVarFromTextCropper_Int_1,UnknownVarFromTextCropper_TextField_1.textHeight / 2);
            param1.text = param1.text.slice(0,_loc2_) + UnknownVarFromTextCropper_String_1;
         }
      }
   }
}

