#!/usr/bin/env python3
"""
Generate Open Graph social media image for Matrix Lab
Requires: pip install pillow
"""

try:
    from PIL import Image, ImageDraw, ImageFont
    import os
    
    # Create image 1200x630 (Open Graph standard)
    width, height = 1200, 630
    
    # Create gradient background
    img = Image.new('RGB', (width, height), color='#123456')
    draw = ImageDraw.Draw(img)
    
    # Add gradient effect
    for i in range(height):
        r = int(18 + (85 - 18) * i / height)
        g = int(52 + (110 - 52) * i / height)
        b = int(86 + (30 - 86) * i / height)
        draw.rectangle([(0, i), (width, i+1)], fill=(r, g, b))
    
    # Add text
    try:
        # Try to use a nice font
        title_font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 80)
        subtitle_font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 40)
    except:
        # Fallback to default font
        title_font = ImageFont.load_default()
        subtitle_font = ImageFont.load_default()
    
    # Draw title
    title = "Matrix Lab"
    title_bbox = draw.textbbox((0, 0), title, font=title_font)
    title_width = title_bbox[2] - title_bbox[0]
    title_x = (width - title_width) // 2
    draw.text((title_x, 180), title, fill='white', font=title_font)
    
    # Draw subtitle
    subtitle = "Blockchain • Federated Learning • Web 3.0"
    subtitle_bbox = draw.textbbox((0, 0), subtitle, font=subtitle_font)
    subtitle_width = subtitle_bbox[2] - subtitle_bbox[0]
    subtitle_x = (width - subtitle_width) // 2
    draw.text((subtitle_x, 300), subtitle, fill='#cccccc', font=subtitle_font)
    
    # Draw tagline
    tagline = "Research in Decentralized Systems & AI"
    tagline_bbox = draw.textbbox((0, 0), tagline, font=subtitle_font)
    tagline_width = tagline_bbox[2] - tagline_bbox[0]
    tagline_x = (width - tagline_width) // 2
    draw.text((tagline_x, 380), tagline, fill='#aaaaaa', font=subtitle_font)
    
    # Save image
    output_dir = 'assets/images'
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, 'og-image.png')
    img.save(output_path, 'PNG', optimize=True)
    
    print(f"✅ Open Graph image created: {output_path}")
    print(f"   Size: {width}x{height}px")
    print(f"   Update _config.yml metadata.image to: /{output_path}")
    
except ImportError:
    print("❌ PIL/Pillow not installed")
    print("   Install with: pip install pillow")
    print("   Or create image manually at 1200x630px")
except Exception as e:
    print(f"❌ Error: {e}")
    print("   Create image manually at 1200x630px")
