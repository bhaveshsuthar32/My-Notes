import { useMemo, useState } from "react";
import Navbar from "../../components/navbar";
import { Link } from "react-router-dom";

const dummyNotes = [
  {
    id: 1,
    title: "Understanding Event Loop in NodeJS",
    subtitle: "How NodeJS handles asynchronous operations",
    topic: "Programming",
    createdAt: "2026-01-20",
    readingTime: "6 min",
    image:
      "https://images.unsplash.com/photo-1515879218367-8466d910aaa4",
  },
  {
    id: 2,
    title: "What is MERN Stack?",
    subtitle: "MongoDB, Express, React, Node explained",
    topic: "Programming",
    createdAt: "2026-01-18",
    readingTime: "5 min",
    image:
      "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
  },
  {
    id: 3,
    title: "English Tenses Basics",
    subtitle: "Learn present, past and future tenses",
    topic: "English",
    createdAt: "2026-01-10",
    readingTime: "4 min",
    image:
      "https://images.unsplash.com/photo-1503676260728-1c00da094a0b",
  },
  {
    id: 4,
    title: "Flutter Widgets Introduction",
    subtitle: "Stateless vs Stateful widgets",
    topic: "Flutter",
    createdAt: "2026-01-25",
    readingTime: "7 min",
    image:
      "https://images.unsplash.com/photo-1555949963-aa79dcee981c",
  },
];

export default function All_Notes() {
  const [notes] = useState(dummyNotes);
  const [search, setSearch] = useState("");
  const [selectedTopic, setSelectedTopic] = useState("All");
  const [sortBy, setSortBy] = useState("latest");

  const topics = useMemo(() => {
    return ["All", ...new Set(dummyNotes.map((n) => n.topic))];
  }, []);

  const filteredNotes = useMemo(() => {
    let data = [...notes];

    // Search
    if (search) {
      data = data.filter((n) =>
        n.title.toLowerCase().includes(search.toLowerCase())
      );
    }

    // Topic filter
    if (selectedTopic !== "All") {
      data = data.filter((n) => n.topic === selectedTopic);
    }

    // Sorting
    switch (sortBy) {
      case "latest":
        data.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
        break;
      case "oldest":
        data.sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));
        break;
      case "az":
        data.sort((a, b) => a.title.localeCompare(b.title));
        break;
      case "za":
        data.sort((a, b) => b.title.localeCompare(a.title));
        break;
      default:
        break;
    }

    return data;
  }, [notes, search, selectedTopic, sortBy]);

  return (
    <>
          <Navbar />
    <div className="min-h-screen bg-gray-50 px-6 py-6">
      {/* Header */}

      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-800">All Notes</h1>
          <p className="text-gray-500">
            Browse all published notes in one place
          </p>
        </div>

        <button className="bg-blue-600 text-white px-5 py-2 rounded-lg hover:bg-blue-700 transition">
          + New Note
        </button>
      </div>

      {/* Search & Filters */}
      <div className="bg-white p-4 rounded-xl shadow-sm flex flex-col md:flex-row gap-4 items-start md:items-center mb-8">
        {/* Search */}
        <input
          type="text"
          placeholder="Search notes..."
          className="w-full md:w-1/3 border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />

        {/* Topic Select */}
        <select
          className="border rounded-lg px-4 py-2 bg-white"
          value={selectedTopic}
          onChange={(e) => setSelectedTopic(e.target.value)}
        >
          {topics.map((topic, i) => (
            <option key={i} value={topic}>
              {topic}
            </option>
          ))}
        </select>

        {/* Sort Select */}
        <select
          className="border rounded-lg px-4 py-2 bg-white"
          value={sortBy}
          onChange={(e) => setSortBy(e.target.value)}
        >
          <option value="latest">Latest Notes</option>
          <option value="oldest">Oldest Notes</option>
          <option value="az">A – Z</option>
          <option value="za">Z – A</option>
        </select>
      </div>

      {/* Notes Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {filteredNotes.length === 0 ? (
          <p className="text-gray-500">No notes found.</p>
        ) : (
          filteredNotes.map((note) => (
            <div
              key={note.id}
              className="bg-white rounded-xl shadow hover:shadow-lg transition overflow-hidden"
            >
              <img
                src={note.image}
                alt={note.title}
                className="h-44 w-full object-cover"
              />

              <div className="p-4">
                <div className="flex items-center justify-between text-sm text-gray-500 mb-2">
                  <span className="bg-gray-100 px-2 py-1 rounded">
                    {note.topic}
                  </span>
                  <span>{note.readingTime}</span>
                </div>

                <h2 className="text-lg font-semibold text-gray-800">
                  {note.title}
                </h2>
                <p className="text-gray-600 text-sm mt-1">
                  {note.subtitle}
                </p>

                <div className="flex items-center justify-between mt-4">
                  <Link to={"/notes"} className="text-blue-600 font-medium hover:underline">
                    Read →
                  </Link>

                  <button className="text-red-500 hover:text-red-700">
                    🗑
                  </button>
                </div>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
    </>
  );
}
