<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>INVESTHAUS | THE MANOR HQ</title>
    
    <!-- Core Dependencies -->
    <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Lucide Icons (Universal UMD Build) -->
    <script src="https://unpkg.com/lucide@0.469.0/dist/umd/lucide.min.js"></script>
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700;900&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap');
        
        :root {
            --gold: #f59e0b;
            --bg: #020202;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg); 
            color: #d4d4d8; 
            margin: 0; 
            overflow: hidden;
        }

        .font-mono { font-family: 'JetBrains+Mono', monospace; }

        @keyframes ticker { 0% { transform: translateX(0); } 100% { transform: translateX(-50%); } }
        .animate-ticker { animation: ticker 40s linear infinite; }
        
        .no-scrollbar::-webkit-scrollbar { display: none; }
        
        .fade-in { 
            animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards; 
        }
        
        @keyframes fadeIn { 
            from { opacity: 0; transform: translateY(10px); } 
            to { opacity: 1; transform: translateY(0); } 
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: rgba(245, 158, 11, 0.5) !important;
            box-shadow: 0 0 20px rgba(245, 158, 11, 0.1);
        }

        input[type="range"] {
            accent-color: #f59e0b;
        }

        .gold-gradient {
            background: linear-gradient(135deg, #f59e0b 0%, #78350f 100%);
        }
        
        .manifesto-stroke {
            -webkit-text-stroke: 1px rgba(255, 255, 255, 0.1);
            color: transparent;
        }

        .glass-panel {
            background: rgba(255, 255, 255, 0.02);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
    </style>
</head>
<body>
    <div id="root"></div>

    <script type="text/babel">
        const { useState, useEffect } = React;

        const Icon = ({ name, size = 20, className = "", strokeWidth = 2 }) => {
            const iconData = window.lucide ? window.lucide.icons[name] : null;
            if (!iconData) return <div style={{ width: size, height: size }} className={className} />;
            const children = iconData[2] || [];
            return (
                <svg
                    width={size}
                    height={size}
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth={strokeWidth}
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    className={className}
                    dangerouslySetInnerHTML={{ 
                        __html: children.map(tag => {
                            const [tagName, attrs] = tag;
                            const attrStr = Object.entries(attrs)
                                .map(([k, v]) => `${k}="${v}"`)
                                .join(' ');
                            return `<${tagName} ${attrStr}></${tagName}>`;
                        }).join('') 
                    }}
                />
            );
        };

        const App = () => {
            const [activeTab, setActiveTab] = useState('manifesto');
            const [currentTime, setCurrentTime] = useState(new Date());
            const [sessionStatus, setSessionStatus] = useState({ london: false, ny: false, tokyo: false });

            // State for interactive features
            const [trades, setTrades] = useState([
                { ticker: 'NAS100', pnl: '+$6,800', side: 'Long', timestamp: 'Dec 30' },
                { ticker: 'BTC/USD', pnl: '+$12,500', side: 'Long', timestamp: 'Dec 29' },
                { ticker: 'XAUUSD', pnl: '-$850', side: 'Short', timestamp: 'Dec 28' }
            ]);

            const [dailyData, setDailyData] = useState({
                bias: 'Neutral',
                narrative: '',
                watchlist: [{ ticker: 'NAS100', level: '16850', bias: 'LONG' }],
                rules: { sl: false, revenge: false, journal: false }
            });

            const [audit, setAudit] = useState({
                discipline: 80,
                patience: 70,
                clarity: 90,
                notes: ''
            });

            useEffect(() => {
                const updateClocks = () => {
                    const now = new Date();
                    setCurrentTime(now);
                    const utcHour = now.getUTCHours();
                    setSessionStatus({
                        london: utcHour >= 8 && utcHour < 16,
                        ny: utcHour >= 13 && utcHour < 21,
                        tokyo: utcHour >= 0 && utcHour < 8
                    });
                };
                updateClocks();
                const timer = setInterval(updateClocks, 1000);
                return () => clearInterval(timer);
            }, []);

            const addTrade = (trade) => {
                setTrades([trade, ...trades]);
            };

            const menuItems = [
                { id: 'manifesto', label: 'MANIFESTO', icon: "Shield", sub: 'The Code & Culture' },
                { id: 'daily', label: 'DAILY EDGE', icon: "Zap", sub: 'Strategic Execution' },
                { id: 'weekly', label: 'WEEKLY SYNC', icon: "Calendar", sub: 'Review & Refresh' },
                { id: 'journal', label: 'TRADE VAULT', icon: "Lock", sub: 'Performance Logs' },
                { id: 'signals', label: 'LIVE SIGNALS', icon: "Radio", sub: 'Alpha Setups' },
                { id: 'desk', label: 'ECONOMIC DESK', icon: "Globe", sub: 'Macro Impact' },
                { id: 'education', label: 'THE ACADEMY', icon: "BookOpen", sub: 'Intel Archives' },
            ];

            const tickerAssets = [
                { symbol: 'NAS100', price: '16,842', change: '+1.4%' },
                { symbol: 'SPX500', price: '4,820', change: '+0.8%' },
                { symbol: 'GOLD', price: '2,042', change: '-0.2%' },
                { symbol: 'BTCUSD', price: '42,950', change: '+4.5%' },
                { symbol: 'EURUSD', price: '1.092', change: '+0.1%' },
                { symbol: 'GBPUSD', price: '1.271', change: '-0.3%' },
                { symbol: 'US30', price: '37,650', change: '+0.5%' }
            ];

            return (
                <div className="flex h-screen bg-[#020202] text-zinc-300 overflow-hidden">
                    {/* Sidebar */}
                    <aside className="w-64 border-r border-white/5 flex flex-col p-6 bg-[#050505] z-30 shadow-2xl">
                        <div className="mb-12 flex flex-col items-center">
                            <div className="relative group cursor-pointer">
                                <div className="absolute -inset-2 bg-gradient-to-r from-amber-500 to-amber-900 rounded-sm blur opacity-20 group-hover:opacity-60 transition duration-1000"></div>
                                <div className="relative w-16 h-16 bg-black border border-amber-500/40 rounded-sm flex items-center justify-center">
                                    <span className="text-amber-500 font-black text-2xl italic uppercase tracking-tighter">H</span>
                                </div>
                            </div>
                            <h1 className="text-2xl font-black tracking-[0.2em] text-white uppercase italic mt-6 leading-none text-center">Investhaus</h1>
                            <p className="text-[10px] text-amber-500 font-black tracking-[0.4em] uppercase mt-2 italic text-center leading-tight">THE MANOR <br/> <span className="opacity-50 text-[8px]">HQ</span></p>
                        </div>

                        <nav className="flex-1 space-y-8 overflow-y-auto no-scrollbar text-left">
                            <div>
                                <p className="text-[9px] text-zinc-600 font-bold uppercase tracking-[0.2em] mb-4 px-4 flex items-center gap-2">
                                    <Icon name="Activity" size={12} /> ACCESS TERMINAL
                                </p>
                                {menuItems.slice(0, 6).map(item => (
                                    <button
                                        key={item.id}
                                        onClick={() => setActiveTab(item.id)}
                                        className={`w-full flex items-center justify-between px-4 py-3 rounded-sm transition-all duration-300 mb-1 ${
                                            activeTab === item.id 
                                                ? 'bg-amber-500/10 text-amber-500 border-l-4 border-amber-500 shadow-[0_0_20px_rgba(245,158,11,0.1)]' 
                                                : 'text-zinc-500 hover:bg-white/5 hover:text-zinc-200'
                                        }`}
                                    >
                                        <div className="flex flex-col items-start text-left">
                                            <div className="flex items-center space-x-3">
                                                <Icon name={item.icon} size={18} />
                                                <span className="font-black tracking-widest uppercase text-[10px] italic">{item.label}</span>
                                            </div>
                                            {activeTab === item.id && <span className="text-[7px] mt-1 ml-7 text-amber-500/50 font-bold tracking-tighter uppercase">{item.sub}</span>}
                                        </div>
                                    </button>
                                ))}
                            </div>
                            <div>
                                <p className="text-[9px] text-zinc-600 font-bold uppercase tracking-[0.2em] mb-4 px-4 flex items-center gap-2">
                                    <Icon name="Crown" size={12} /> LEGACY INTEL
                                </p>
                                {menuItems.slice(6).map(item => (
                                    <button
                                        key={item.id}
                                        onClick={() => setActiveTab(item.id)}
                                        className={`w-full flex items-center justify-between px-4 py-4 rounded-sm transition-all duration-300 mb-1 ${
                                            activeTab === item.id 
                                                ? 'bg-amber-500/10 text-amber-500 border-l-4 border-amber-500' 
                                                : 'text-zinc-500 hover:bg-white/5 hover:text-zinc-200'
                                        }`}
                                    >
                                        <div className="flex flex-col items-start text-left">
                                            <div className="flex items-center space-x-3">
                                                <Icon name={item.icon} size={18} />
                                                <span className="font-black tracking-widest uppercase text-[10px] italic">{item.label}</span>
                                            </div>
                                        </div>
                                    </button>
                                ))}
                            </div>
                        </nav>

                        <div className="mt-auto pt-6 border-t border-white/5">
                            <div className="p-4 bg-zinc-900/40 border border-white/5 rounded-sm relative overflow-hidden">
                                <div className="flex items-center space-x-3 text-left">
                                    <div className="w-10 h-10 rounded-sm bg-amber-500 flex items-center justify-center text-black font-black text-xs italic">IH</div>
                                    <div className="flex-1 overflow-hidden">
                                        <p className="text-[10px] font-black text-white truncate uppercase tracking-tighter italic">Legacy Architect</p>
                                        <p className="text-[8px] text-amber-500 font-mono truncate uppercase tracking-[0.1em]">EST. IN EXCELLENCE</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </aside>

                    {/* Main Workspace */}
                    <main className="flex-1 overflow-y-auto relative bg-[#020202]">
                        <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-amber-500/[0.04] blur-[150px] pointer-events-none"></div>

                        <header className="px-10 py-7 flex justify-between items-center sticky top-0 bg-[#020202]/95 backdrop-blur-xl z-20 border-b border-white/5">
                            <div className="flex items-center space-x-10">
                                <h2 className="text-2xl font-black text-white tracking-tighter uppercase italic flex items-center gap-4">
                                   <span className="text-amber-500 text-sm">/</span> {menuItems.find(i => i.id === activeTab)?.label}
                                </h2>
                                <div className="hidden lg:flex items-center space-x-8 text-[10px] font-black uppercase tracking-[0.2em]">
                                    <div className={`flex items-center gap-2 ${sessionStatus.ny ? 'text-green-500' : 'text-zinc-700'}`}>
                                        <Icon name="Globe" size={13}/> NY: <span className="font-bold">{sessionStatus.ny ? 'OPEN' : 'CLOSED'}</span>
                                    </div>
                                    <div className={`flex items-center gap-2 ${sessionStatus.london ? 'text-green-500' : 'text-zinc-700'}`}>
                                        <Icon name="Globe" size={13}/> LDN: <span className="font-bold">{sessionStatus.london ? 'OPEN' : 'CLOSED'}</span>
                                    </div>
                                    <div className={`flex items-center gap-2 ${sessionStatus.tokyo ? 'text-green-500' : 'text-zinc-700'}`}>
                                        <Icon name="Globe" size={13}/> TKY: <span className="font-bold">{sessionStatus.tokyo ? 'OPEN' : 'CLOSED'}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div className="flex items-center space-x-6">
                                <div className="flex items-center gap-2 text-zinc-500 font-mono text-[11px] uppercase tracking-widest bg-white/5 px-4 py-2 rounded-sm border border-white/5">
                                    <Icon name="Clock" size={14} className="text-amber-500" />
                                    {currentTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false })}
                                </div>
                                <div className="px-4 py-2 bg-amber-500 text-black rounded-sm text-[10px] font-black tracking-widest uppercase italic shadow-[0_0_20px_rgba(245,158,11,0.2)]">MANOR HQ</div>
                            </div>
                        </header>

                        <div className="p-10 max-w-6xl mx-auto pb-40">
                            {activeTab === 'manifesto' && <ManifestoView />}
                            {activeTab === 'daily' && <DailyEdgeView data={dailyData} setDailyData={setDailyData} />}
                            {activeTab === 'weekly' && <WeeklySyncView audit={audit} setAudit={setAudit} />}
                            {activeTab === 'journal' && <TradeVaultView trades={trades} addTrade={addTrade} />}
                            {activeTab === 'signals' && <SignalsView />}
                            {activeTab === 'desk' && <DeskView />}
                            {activeTab === 'education' && <EducationView />}
                        </div>

                        {/* Scrolling Ticker */}
                        <div className="fixed bottom-0 right-0 left-64 h-12 bg-black border-t border-white/10 flex items-center overflow-hidden z-20">
                            <div className="flex whitespace-nowrap animate-ticker py-2 text-[11px] font-mono font-bold">
                                {Array(5).fill(tickerAssets).flat().map((asset, i) => (
                                    <span key={i} className="mx-10 uppercase flex items-center gap-4">
                                        <span className="text-amber-500 font-black italic tracking-tighter">{asset.symbol}</span> 
                                        <span className="text-white">${asset.price}</span> 
                                        <span className={asset.change.includes('+') ? 'text-green-500' : 'text-red-500'}>{asset.change}</span>
                                    </span>
                                ))}
                            </div>
                        </div>
                    </main>
                </div>
            );
        };

        const ManifestoView = () => (
            <div className="fade-in max-w-6xl py-12 text-left text-zinc-100">
                <div className="inline-flex items-center gap-6 mb-10">
                    <div className="h-[2px] w-16 bg-amber-500"></div>
                    <span className="text-amber-500 font-black text-xs uppercase tracking-[0.6em] italic text-left">The Code of the Manor</span>
                </div>
                
                <div className="relative mb-20">
                    <h1 className="text-[10rem] font-black text-white leading-[0.75] italic uppercase opacity-[0.98] tracking-tighter">
                        THE <br/>
                        <span className="text-transparent bg-clip-text bg-gradient-to-r from-amber-200 via-amber-500 to-amber-800 font-black">BLUEPRINT</span>
                    </h1>
                    <p className="absolute bottom-4 right-0 manifesto-stroke text-8xl font-black italic uppercase select-none">SOVEREIGNTY</p>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-2 gap-24 border-l-2 border-amber-500/20 pl-16 py-8 relative">
                    <div className="absolute top-0 left-[-3px] w-1.5 h-48 bg-amber-500 shadow-[0_0_20px_rgba(245,158,11,0.5)]"></div>
                    <div className="space-y-10">
                        <p className="text-3xl leading-tight font-black italic uppercase tracking-tight">
                            This is the standard. <br/> We don't trade for crumbs; we build for centuries.
                        </p>
                        <p className="text-sm text-zinc-500 leading-relaxed uppercase tracking-[0.2em] font-black">
                            Radical ownership. Precise execution. Long-term legacy.
                        </p>
                    </div>
                </div>
            </div>
        );

        const SignalsView = () => (
            <div className="fade-in space-y-12">
                <div className="p-10 border border-white/5 bg-zinc-900/10 rounded-sm text-center">
                    <Icon name="Radio" size={48} className="mx-auto text-amber-500 mb-6 animate-pulse" />
                    <h3 className="text-2xl font-black italic uppercase tracking-tighter text-white">Live Signal Stream</h3>
                    <p className="text-zinc-600 uppercase text-[10px] tracking-[0.5em] mt-2">Connecting to Alpha Nodes...</p>
                    <div className="mt-12 grid grid-cols-1 md:grid-cols-2 gap-6 text-left">
                        {[
                            { pair: 'XAU/USD', bias: 'LONG', level: '2042.10', status: 'PENDING' },
                            { pair: 'NAS100', bias: 'SHORT', level: '16820', status: 'MONITOR' }
                        ].map((sig, i) => (
                            <div key={i} className="p-6 bg-white/[0.02] border border-white/5 rounded-sm">
                                <div className="flex justify-between items-center mb-4">
                                    <span className="text-xl font-black italic text-white">{sig.pair}</span>
                                    <span className="text-[10px] font-black bg-amber-500 text-black px-2 py-1">{sig.status}</span>
                                </div>
                                <p className="text-[10px] font-bold text-zinc-500 uppercase tracking-widest">Entry Zone: <span className="text-amber-500">{sig.level}</span></p>
                                <p className="text-[10px] font-bold text-zinc-500 uppercase tracking-widest">Bias: <span className={sig.bias === 'LONG' ? 'text-green-500' : 'text-red-500'}>{sig.bias}</span></p>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        );

        const DeskView = () => (
            <div className="fade-in space-y-12">
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
                    <div className="p-10 bg-zinc-900/10 border border-white/5 rounded-sm">
                        <h4 className="text-[11px] font-black text-amber-500 uppercase tracking-[0.4em] mb-8 italic">High Impact Events</h4>
                        <div className="space-y-6">
                            {[
                                { event: 'USD: Non-Farm Payrolls', impact: 'HIGH', time: 'Friday 08:30' },
                                { event: 'USD: CPI Data', impact: 'HIGH', time: 'Tuesday 08:30' }
                            ].map((e, i) => (
                                <div key={i} className="flex justify-between items-center border-b border-white/5 pb-4">
                                    <div>
                                        <p className="text-sm font-black italic text-white uppercase">{e.event}</p>
                                        <p className="text-[10px] font-bold text-zinc-500 uppercase">{e.time}</p>
                                    </div>
                                    <span className="text-[9px] font-black text-red-500 bg-red-500/10 px-2 py-1 border border-red-500/20">{e.impact}</span>
                                </div>
                            ))}
                        </div>
                    </div>
                    <div className="p-10 bg-zinc-900/10 border border-white/5 rounded-sm flex flex-col justify-center items-center text-center">
                        <Icon name="Globe" size={40} className="text-zinc-700 mb-4" />
                        <p className="text-[10px] font-black text-zinc-500 uppercase tracking-[0.3em]">Institutional Sentiment</p>
                        <p className="text-3xl font-black italic text-white uppercase tracking-tighter mt-2">DXY: BULLISH</p>
                    </div>
                </div>
            </div>
        );

        const DailyEdgeView = ({ data, setDailyData }) => {
            const [calc, setCalc] = useState({ account: 10000, risk: 1, sl: 10, result: 0 });
            const calculatePosition = () => {
                const riskAmt = parseFloat(calc.account) * (parseFloat(calc.risk) / 100);
                const size = riskAmt / parseFloat(calc.sl);
                setCalc({ ...calc, result: isNaN(size) ? 0 : size.toFixed(2) });
            };

            return (
                <div className="space-y-10 fade-in text-left">
                    <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
                        <div className="bg-[#080808] border border-white/10 p-8 rounded-sm lg:col-span-1">
                            <p className="text-[10px] font-black text-zinc-600 uppercase tracking-[0.3em] mb-8 italic">Market Bias</p>
                            <div className="flex flex-col gap-3">
                                {['Bullish', 'Neutral', 'Bearish'].map(s => (
                                    <button 
                                        key={s} 
                                        onClick={() => setDailyData({...data, bias: s})}
                                        className={`w-full py-4 text-[10px] font-black uppercase tracking-widest border rounded-sm transition-all italic ${
                                            data.bias === s ? 'bg-amber-500 text-black border-amber-500 shadow-[0_0_25px_rgba(245,158,11,0.3)]' : 'border-white/5 text-zinc-500 hover:bg-white/5'
                                        }`}
                                    >
                                        {s.split(' ')[0]}
                                    </button>
                                ))}
                            </div>
                        </div>

                        <div className="lg:col-span-3 bg-[#080808] border border-white/10 p-8 rounded-sm relative group">
                            <div className="absolute top-0 right-0 p-6 opacity-5"><Icon name="Calculator" size={50} /></div>
                            <p className="text-[10px] font-black text-zinc-600 uppercase tracking-[0.3em] mb-8 text-left">Risk Calculator</p>
                            <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
                                <div className="space-y-2 text-left">
                                    <label className="text-[9px] font-black text-zinc-500 uppercase">Equity ($)</label>
                                    <input type="number" value={calc.account} onChange={e => setCalc({...calc, account: e.target.value})} className="w-full bg-black border border-white/10 rounded-sm px-4 py-3 text-sm text-white font-mono" />
                                </div>
                                <div className="space-y-2 text-left">
                                    <label className="text-[9px] font-black text-zinc-500 uppercase">Risk %</label>
                                    <input type="number" value={calc.risk} onChange={e => setCalc({...calc, risk: e.target.value})} className="w-full bg-black border border-white/10 rounded-sm px-4 py-3 text-sm text-amber-500 font-mono" />
                                </div>
                                <div className="space-y-2 text-left">
                                    <label className="text-[9px] font-black text-zinc-500 uppercase">SL (Pips)</label>
                                    <input type="number" value={calc.sl} onChange={e => setCalc({...calc, sl: e.target.value})} className="w-full bg-black border border-white/10 rounded-sm px-4 py-3 text-sm text-white font-mono" />
                                </div>
                                <div className="flex flex-col justify-end">
                                    <button onClick={calculatePosition} className="py-3 bg-white text-black text-[10px] font-black uppercase rounded-sm hover:bg-amber-500 transition-all italic">Calculate</button>
                                </div>
                            </div>
                            {parseFloat(calc.result) > 0 && (
                                <div className="mt-8 pt-8 border-t border-white/5 flex items-baseline gap-4 text-left">
                                    <span className="text-[10px] font-black text-zinc-500 uppercase">Target Lot Size:</span>
                                    <span className="text-4xl font-black text-white italic underline decoration-amber-500 decoration-2">{calc.result}</span>
                                </div>
                            )}
                        </div>
                    </div>

                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 pt-6">
                        <div className="space-y-6 text-left">
                            <h4 className="text-[11px] font-black text-amber-500 uppercase tracking-[0.4em] italic flex items-center gap-4">
                                <Icon name="Zap" size={15}/> The Daily Blueprint
                            </h4>
                            <textarea 
                                value={data.narrative}
                                onChange={e => setDailyData({...data, narrative: e.target.value})}
                                placeholder="State the narrative for today's session..."
                                className="w-full bg-[#080808] border border-white/10 rounded-sm p-8 text-sm h-72 focus:border-amber-500/40 outline-none resize-none leading-relaxed text-zinc-400 font-mono uppercase tracking-tight shadow-2xl"
                            ></textarea>
                        </div>
                        <div className="space-y-8 text-left">
                            <h4 className="text-[11px] font-black text-amber-500 uppercase tracking-[0.4em] italic">The Code</h4>
                            <div className="bg-[#080808] border border-white/10 rounded-sm p-10 space-y-8 relative overflow-hidden">
                                {['EXECUTE HARD STOPS', 'ZERO REVENGE DEPLOYMENTS', 'MANDATORY LOGGING'].map(rule => (
                                    <label key={rule} className="flex items-center space-x-6 text-[11px] font-black uppercase text-zinc-500 hover:text-white cursor-pointer group transition-all italic tracking-tighter relative z-10">
                                        <input type="checkbox" className="w-6 h-6 rounded-sm bg-black border-2 border-white/10 accent-amber-500 appearance-none checked:bg-amber-500 checked:border-amber-500" />
                                        <span className="group-hover:translate-x-2 transition-transform">{rule}</span>
                                    </label>
                                ))}
                            </div>
                        </div>
                    </div>
                </div>
            );
        };

        const WeeklySyncView = ({ audit, setAudit }) => (
            <div className="fade-in space-y-12 text-left">
                <div className="flex justify-between items-end border-b border-white/5 pb-10">
                    <div>
                        <h3 className="text-5xl font-black text-white italic uppercase tracking-tighter">Weekly Sync</h3>
                        <p className="text-[11px] text-zinc-600 font-black uppercase tracking-[0.4em] mt-2 italic">Culture & Psychological Audit</p>
                    </div>
                    <div className="text-right">
                        <span className="text-[10px] font-black text-amber-500 uppercase italic">State Score</span>
                        <p className="text-4xl font-black italic text-white leading-none">{( (audit.discipline + audit.patience + audit.clarity) / 3 ).toFixed(0)}%</p>
                    </div>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <div className="bg-[#080808] border border-white/10 p-8 rounded-sm space-y-6">
                        <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black uppercase tracking-widest text-zinc-500">Discipline</span>
                            <span className="text-xl font-black italic text-amber-500">{audit.discipline}%</span>
                        </div>
                        <input type="range" min="0" max="100" value={audit.discipline} onChange={(e) => setAudit({...audit, discipline: parseInt(e.target.value)})} className="w-full" />
                    </div>
                    <div className="bg-[#080808] border border-white/10 p-8 rounded-sm space-y-6">
                        <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black uppercase tracking-widest text-zinc-500">Patience</span>
                            <span className="text-xl font-black italic text-amber-500">{audit.patience}%</span>
                        </div>
                        <input type="range" min="0" max="100" value={audit.patience} onChange={(e) => setAudit({...audit, patience: parseInt(e.target.value)})} className="w-full" />
                    </div>
                    <div className="bg-[#080808] border border-white/10 p-8 rounded-sm space-y-6">
                        <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black uppercase tracking-widest text-zinc-500">Clarity</span>
                            <span className="text-xl font-black italic text-amber-500">{audit.clarity}%</span>
                        </div>
                        <input type="range" min="0" max="100" value={audit.clarity} onChange={(e) => setAudit({...audit, clarity: parseInt(e.target.value)})} className="w-full" />
                    </div>
                </div>

                <div className="bg-[#080808] border border-white/10 p-10 rounded-sm">
                    <h4 className="text-[11px] font-black text-amber-500 uppercase tracking-[0.4em] mb-6 italic text-left">Weekly Synthesis</h4>
                    <textarea className="w-full bg-black/40 border border-white/10 rounded-sm p-6 text-sm h-48 focus:border-amber-500 outline-none font-mono uppercase tracking-tight" placeholder="Log breakthroughs..." value={audit.notes} onChange={(e) => setAudit({...audit, notes: e.target.value})} />
                </div>
            </div>
        );

        const TradeVaultView = ({ trades, addTrade }) => {
            const [newTrade, setNewTrade] = useState({ ticker: '', pnl: '', side: 'Long' });
            const handleLog = () => {
                if (newTrade.ticker && newTrade.pnl) {
                    addTrade({ ...newTrade, timestamp: 'Dec 30' });
                    setNewTrade({ ticker: '', pnl: '', side: 'Long' });
                }
            };
            return (
                <div className="fade-in space-y-12 text-left">
                    <div className="flex flex-col lg:flex-row lg:items-end justify-between border-b border-white/5 pb-10">
                        <div>
                            <h3 className="text-5xl font-black text-white italic uppercase tracking-tighter text-left">Trade Vault</h3>
                            <p className="text-[11px] text-zinc-600 font-black uppercase tracking-[0.4em] mt-2 italic text-left">Performance Archives</p>
                        </div>
                        <div className="mt-8 lg:mt-0 flex flex-wrap gap-4 items-center bg-zinc-900/30 p-4 rounded-sm border border-white/5">
                            <input value={newTrade.ticker} onChange={(e) => setNewTrade({...newTrade, ticker: e.target.value.toUpperCase()})} placeholder="ASSET" className="bg-black border border-white/10 px-4 py-2 text-[10px] font-black text-white w-32 outline-none focus:border-amber-500" />
                            <input value={newTrade.pnl} onChange={(e) => setNewTrade({...newTrade, pnl: e.target.value})} placeholder="RETURN" className="bg-black border border-white/10 px-4 py-2 text-[10px] font-black text-white w-40 outline-none focus:border-amber-500" />
                            <select value={newTrade.side} onChange={(e) => setNewTrade({...newTrade, side: e.target.value})} className="bg-black border border-white/10 px-4 py-2 text-[10px] font-black text-amber-500 outline-none uppercase"><option>Long</option><option>Short</option></select>
                            <button onClick={handleLog} className="bg-amber-500 text-black px-6 py-2 rounded-sm font-black text-[10px] uppercase italic tracking-widest hover:bg-white transition-all">Log Trade</button>
                        </div>
                    </div>
                    <div className="grid grid-cols-1 gap-4">
                        {trades.map((t, i) => (
                            <div key={i} className="flex items-center justify-between px-10 py-8 bg-white/[0.01] border border-white/5 rounded-sm transition-all group shadow-xl">
                                <div className="flex items-center gap-8"><span className="text-[10px] font-mono text-zinc-700 font-black uppercase">{t.timestamp}</span><span className="text-3xl font-black italic uppercase tracking-tighter text-white group-hover:text-amber-500 transition-colors">{t.ticker}</span></div>
                                <div className="flex items-center gap-12"><div className={`text-[10px] font-black uppercase tracking-widest px-4 py-1.5 border rounded-sm italic ${t.pnl.includes('+') ? 'border-amber-500/20 text-amber-500 bg-amber-500/5' : 'border-red-500/20 text-red-500 bg-red-500/5'}`}>{t.side}</div><span className={`text-3xl font-mono font-black italic tracking-tighter ${t.pnl.includes('+') ? 'text-green-500' : 'text-red-500'}`}>{t.pnl}</span></div>
                            </div>
                        ))}
                    </div>
                </div>
            );
        };

        const EducationView = () => {
            const [selectedModule, setSelectedModule] = useState(null);
            const [step, setStep] = useState(0);

            const modules = [
                { 
                    id: 'foundation', 
                    title: 'The Foundation', 
                    icon: 'Shield',
                    lessons: [
                        { title: 'Market Structure 101', content: 'Price moves in trends. A bullish trend is defined by Higher Highs (HH) and Higher Lows (HL). Identifying these early is the key to Manor-level profit.', visual: 'HH / HL Sequence' },
                        { title: 'Risk Sovereignty', content: 'Never risk more than 1% of your account on a single deployment. Capital preservation is the first rule of the Haus. Survival precedes success.', visual: 'The 1% Standard' },
                        { title: 'Institutional Footprints', content: 'Look for imbalances. Large candles with "fair value gaps" show where the big money entered. We position where they deploy.', visual: 'FVG Identification' }
                    ]
                },
                { id: 'alchemy', title: 'Advanced Alchemy', icon: 'Sparkles', lessons: [] },
                { id: 'ledger', title: 'Wealth Ledger', icon: 'Lock', lessons: [] }
            ];

            if (selectedModule) {
                const module = modules.find(m => m.id === selectedModule);
                const currentLesson = module.lessons[step];

                return (
                    <div className="fade-in space-y-12">
                        <button onClick={() => { setSelectedModule(null); setStep(0); }} className="text-amber-500 uppercase font-black text-[10px] flex items-center gap-2 hover:underline">
                            <Icon name="ChevronRight" size={14} className="rotate-180" /> Back to Archives
                        </button>
                        
                        <div className="p-16 glass-panel rounded-sm relative overflow-hidden">
                            <div className="absolute top-0 right-0 p-8 text-white/[0.02]"><Icon name={module.icon} size={200} /></div>
                            <div className="relative z-10 text-left">
                                <p className="text-amber-500 font-black text-xs uppercase tracking-[0.4em] mb-4">Lesson {step + 1} of {module.lessons.length}</p>
                                <h3 className="text-6xl font-black text-white italic uppercase tracking-tighter mb-8">{currentLesson.title}</h3>
                                <p className="text-zinc-400 text-xl leading-relaxed max-w-2xl font-medium italic opacity-90 mb-12">{currentLesson.content}</p>
                                
                                <div className="p-10 border border-amber-500/20 bg-amber-500/5 rounded-sm mb-12 text-center">
                                    <p className="text-zinc-500 uppercase text-[9px] font-black tracking-[0.5em] mb-4">Manor Visual Guide</p>
                                    <p className="text-3xl font-black text-white italic tracking-tighter uppercase">{currentLesson.visual}</p>
                                </div>

                                <div className="flex gap-4">
                                    <button 
                                        disabled={step === 0}
                                        onClick={() => setStep(step - 1)}
                                        className="px-8 py-3 border border-white/10 rounded-sm text-[10px] font-black uppercase disabled:opacity-20 transition-all hover:bg-white/5"
                                    >
                                        Previous
                                    </button>
                                    <button 
                                        onClick={() => step < module.lessons.length - 1 ? setStep(step + 1) : setSelectedModule(null)}
                                        className="px-12 py-3 bg-amber-500 text-black rounded-sm text-[10px] font-black uppercase transition-all hover:bg-white"
                                    >
                                        {step < module.lessons.length - 1 ? 'Next Chapter' : 'Complete Module'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                );
            }

            return (
                <div className="fade-in py-12 text-left space-y-12">
                    <div className="p-16 bg-gradient-to-br from-zinc-900 to-black border border-white/10 rounded-sm relative overflow-hidden shadow-2xl">
                        <div className="absolute top-0 right-0 p-16 text-white/5 pointer-events-none"><Icon name="Library" size={200} /></div>
                        <div className="relative z-10 text-left">
                            <p className="text-amber-500 font-black text-xs uppercase tracking-[0.7em] mb-6 italic">Intel Archives</p>
                            <h3 className="text-7xl font-black text-white italic uppercase tracking-tighter mb-10 leading-none">The Academy</h3>
                            <p className="text-zinc-500 text-lg max-w-2xl uppercase font-black tracking-tighter mb-12 opacity-80 leading-tight italic">Blueprint for sovereignty. Master the data. Build the legacy.</p>
                            <button className="bg-white text-black font-black text-[11px] uppercase px-10 py-4 tracking-[0.3em] hover:bg-amber-500 transition-all italic shadow-2xl">Enter Archives</button>
                        </div>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
                        {modules.map((m, i) => (
                            <div key={m.id} onClick={() => m.lessons.length > 0 && setSelectedModule(m.id)} className={`group p-10 bg-[#080808] border border-white/10 rounded-sm hover:border-amber-500/50 transition-all cursor-pointer relative overflow-hidden text-left ${m.lessons.length === 0 ? 'opacity-30 cursor-not-allowed' : ''}`}>
                                <div className="absolute top-0 right-0 p-4 opacity-[0.02] text-white"><Icon name={m.icon} size={80}/></div>
                                <div className="text-zinc-800 text-7xl font-black mb-6 italic group-hover:text-amber-500 transition-colors opacity-30">0{i+1}</div>
                                <h4 className="text-white font-black text-sm uppercase tracking-[0.2em] mb-4 italic">{m.title}</h4>
                                <p className="text-zinc-600 text-[10px] leading-relaxed uppercase font-black tracking-widest italic">{m.lessons.length > 0 ? 'Course Material Ready' : 'Content Encrypted'}</p>
                            </div>
                        ))}
                    </div>
                </div>
            );
        };

        const container = document.getElementById('root');
        const root = ReactDOM.createRoot(container);
        root.render(<App />);
    </script>
</body>
</html>
