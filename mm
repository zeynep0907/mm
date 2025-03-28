import discord
from discord.ext import commands
import logging

# Logları kaydetme
logging.basicConfig(level=logging.INFO, filename="bot.log",
                    format="%(asctime)s - %(levelname)s - %(message)s")

# Bot prefixini belirle
intents = discord.Intents.all()
bot = commands.Bot(command_prefix="!", intents=intents)

# Bot başlatıldığında çalışacak event
@bot.event
async def on_ready():
    print(f"{bot.user} olarak giriş yapıldı!")
    logging.info(f"{bot.user} olarak giriş yapıldı!")

# Ping komutu
@bot.command()
async def ping(ctx):
    await ctx.send(f"Pong! {round(bot.latency * 1000)}ms")

# Kullanıcı bilgilerini gösterme komutu
@bot.command()
async def userinfo(ctx, member: discord.Member):
    embed = discord.Embed(title=f"{member.name} Kullanıcı Bilgileri", color=discord.Color.blue())
    embed.add_field(name="ID", value=member.id, inline=False)
    embed.add_field(name="Katılma Tarihi", value=member.joined_at.strftime("%Y-%m-%d %H:%M:%S"), inline=False)
    embed.set_thumbnail(url=member.avatar.url)
    await ctx.send(embed=embed)

# Moderasyon - Kullanıcı yasaklama
@bot.command()
@commands.has_permissions(ban_members=True)
async def ban(ctx, member: discord.Member, *, reason="Sebep belirtilmemiş"):
    await member.ban(reason=reason)
    await ctx.send(f"{member.mention} kullanıcısı yasaklandı. Sebep: {reason}")
    logging.info(f"{member} yasaklandı. Sebep: {reason}")

# Kullanıcı sunucuya katıldığında mesaj gönderme
@bot.event
async def on_member_join(member):
    channel = discord.utils.get(member.guild.text_channels, name="genel")  # Kanal adını değiştir
    if channel:
        await channel.send(f"Hoş geldin {member.mention}! Kuralları okumayı unutma.")

# Hata yönetimi
@bot.event
async def on_command_error(ctx, error):
    if isinstance(error, commands.MissingPermissions):
        await ctx.send("Bu komutu kullanmak için yeterli yetkiniz yok.")
    elif isinstance(error, commands.MissingRequiredArgument):
        await ctx.send("Komutu doğru kullanın! Eksik argüman var.")
    else:
        await ctx.send("Bir hata oluştu. Logları kontrol et.")
        logging.error(f"Hata: {error}")

# Token ekleyerek başlat
TOKEN = "YOUR_BOT_TOKEN_HERE"
bot.run(TOKEN)
